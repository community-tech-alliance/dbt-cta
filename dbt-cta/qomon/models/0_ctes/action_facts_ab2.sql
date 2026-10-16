-- action_facts is a link table with no deleted_at, and Qomon re-sends every action_facts row for a
-- fact_id together. Keeping only rows from the latest file containing each fact_id drops removed links.
-- then ensures the base model contains only one row per key

select * except (rownum) from
(
select
    *,
    row_number() over (partition by action_id, fact_id order by _cta_loaded_at desc) as rownum
from (
    select *
    from {{ ref('action_facts_ab1') }}
    where true
    qualify _extracted_at = max(_extracted_at) over (partition by fact_id)
)
)
where rownum = 1
