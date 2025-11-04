CREATE OR REPLACE TEMPORARY TABLE CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.docs_categories AS 
WITH unique_documents AS (
  SELECT
    DISTINCT relative_path, chunk
  FROM
    CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS_CHUNKS_TABLE
  WHERE 
    chunk_index = 0
  ),
 docs_category_cte AS (
  SELECT
    relative_path,
    TRIM(snowflake.cortex.AI_CLASSIFY (
      'Title:' || relative_path || 'Content:' || chunk, ['Clothes', 'Jewelry', 'Fragrance', 'Hair', 'Beard', 'Watches', 'Shave', 'Skin']
     )['labels'][0], '"') AS CATEGORY
  FROM
    unique_documents
)
SELECT
  *
FROM
  docs_category_cte;

update CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS_CHUNKS_TABLE 
  SET category = CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS_CATEGORIES.category
  from CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS_CATEGORIES
  where  CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS_CHUNKS_TABLE.relative_path = CC_QUICKSTART_CORTEX_SEARCH_DOCS.DATA.DOCS_CATEGORIES.relative_path;

  select * from cc_quickstart_cortex_search_docs.data.docs_chunks_table;