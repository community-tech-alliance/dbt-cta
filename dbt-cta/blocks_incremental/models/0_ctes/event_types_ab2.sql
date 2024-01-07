-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_event_types_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('event_types_ab1') }}
)
where rownum=1