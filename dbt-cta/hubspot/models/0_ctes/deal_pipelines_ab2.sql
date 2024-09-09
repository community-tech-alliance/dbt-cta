-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY pipelineId ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('deal_pipelines_ab1') }}
)
where rownum=1