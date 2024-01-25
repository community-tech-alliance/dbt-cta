-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_managed_form_contributions_stream_hashid ORDER BY _airbyte_emmited_at desc) as rownum 
from {{ ref('managed_form_contributions_stream_ab3') }}
)
where rownum=1