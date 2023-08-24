with job_details as (select * from {{ ref('job_details') }}),

parsed as (
    select
        *,
        array_length(referencedTables) as totalReferencedTables,
        regexp_extract(table_referenced, r'datasets/([^/]+)') as datasetId,
        regexp_extract(replace(table_referenced, '"', ''), r'tables/([^/]+)') as tableId
    from job_details
    cross join unnest(referencedTables) as table_referenced
)

select
    *,
    concat(projectId, '.', datasetId, ',', tableId) as full_ref
from parsed
