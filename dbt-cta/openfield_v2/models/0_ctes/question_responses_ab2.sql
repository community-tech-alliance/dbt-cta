-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
(
select
    *,
    row_number() over (partition by _question_responses_hashid order by _cta_loaded_at desc) as rownum
from {{ ref('question_responses_ab1') }}
)
where rownum = 1
