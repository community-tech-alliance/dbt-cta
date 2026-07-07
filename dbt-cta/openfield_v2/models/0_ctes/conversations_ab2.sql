-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
(
select
    *,
    row_number() over (partition by _conversations_hashid order by _cta_loaded_at desc) as rownum
from {{ ref('conversations_ab1') }}
)
where rownum = 1
