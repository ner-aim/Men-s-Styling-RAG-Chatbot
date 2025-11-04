USE DATABASE CC_QUICKSTART_CORTEX_SEARCH_DOCS;

create or replace CORTEX SEARCH SERVICE CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.CC_SEARCH_SERVICE_CS
ON chunk
ATTRIBUTES category
warehouse = COMPUTE_WH
TARGET_LAG = '1 minute'
as (
    select chunk,
        chunk_index,
        relative_path,
        file_url,
        category
    from CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS_CHUNKS_TABLE
);
