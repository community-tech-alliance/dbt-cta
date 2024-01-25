-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_entity_sync_stored_operations_hashid ORDER BY _airbyte_emitted_at desc) as rownum 
from {{ ref('entity_sync_stored_operations_ab3') }}
)
where rownum=1