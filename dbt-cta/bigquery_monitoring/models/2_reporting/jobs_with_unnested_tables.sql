with job_details as (select * from {{ ref('job_details') }}),
parsed as (
SELECT 
  *,
  array_length(referencedTables) as totalReferencedTables,
  REGEXP_EXTRACT(table_referenced, r'datasets/([^/]+)') AS datasetId,
  REGEXP_EXTRACT(replace(table_referenced, '"', ''), r'tables/([^/]+)') AS tableId
FROM job_details as t
CROSS JOIN UNNEST(referencedTables) as table_referenced
)
 
SELECT
*,
concat(projectId,'.',datasetId,',',tableId) as full_ref
FROM parsed