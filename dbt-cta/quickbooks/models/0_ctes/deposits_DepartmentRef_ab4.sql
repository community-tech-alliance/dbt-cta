-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_deposits_DepartmentRef_hashid ORDER BY _airbyte_emitted_at desc) as rownum 
from {{ ref('deposits_DepartmentRef_ab3') }}
)
where rownum=1