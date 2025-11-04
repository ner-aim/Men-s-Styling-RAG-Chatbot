USE DATABASE CC_QUICKSTART_CORTEX_SEARCH_DOCS;
CREATE OR REPLACE TEMPORARY TABLE  CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.RAW_TEXT AS
WITH FILE_TABLE as (
  (SELECT 
        RELATIVE_PATH,
        SIZE,
        FILE_URL,
        build_scoped_file_url(@CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS, relative_path) as scoped_file_url,
        TO_FILE('@CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS', RELATIVE_PATH) AS docs 
    FROM 
        DIRECTORY(@CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS))
)
SELECT 
    RELATIVE_PATH,
    SIZE,
    FILE_URL,
    scoped_file_url,
    TO_VARCHAR (
        SNOWFLAKE.CORTEX.AI_PARSE_DOCUMENT (
            docs,
            {'mode': 'LAYOUT'} ):content
        ) AS EXTRACTED_LAYOUT 
FROM 
    FILE_TABLE;

create or replace TABLE CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS_CHUNKS_TABLE ( 
    RELATIVE_PATH VARCHAR(16777216),
    SIZE NUMBER(38,0), 
    FILE_URL VARCHAR(16777216),
    SCOPED_FILE_URL VARCHAR(16777216), 
    CHUNK VARCHAR(16777216), 
    CHUNK_INDEX INTEGER, 
    CATEGORY VARCHAR(16777216) 
);


insert into CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.docs_chunks_table (relative_path, size, file_url,
                            scoped_file_url, chunk, chunk_index)

    select relative_path, 
            size,
            file_url, 
            scoped_file_url,
            c.value::TEXT as chunk,
            c.INDEX::INTEGER as chunk_index
            
    from 
        raw_text,
        LATERAL FLATTEN( input => SNOWFLAKE.CORTEX.SPLIT_TEXT_RECURSIVE_CHARACTER (
              EXTRACTED_LAYOUT,
              'markdown',
              1512,
              256,
              ['nn', 'n', ' ', '']
           )) c;


