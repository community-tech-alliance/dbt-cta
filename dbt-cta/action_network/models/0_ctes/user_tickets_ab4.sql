-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_user_tickets_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('user_tickets_ab3') }}
)
where rownum=1