-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_visual_review_triggers_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('visual_review_triggers_ab1') }}
)
where rownum=1