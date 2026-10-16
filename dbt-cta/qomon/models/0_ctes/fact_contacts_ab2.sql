-- fact_contacts is a link table with no deleted_at, and Qomon re-sends every fact_contacts row for a
-- contact_id together. Keeping only rows from the latest file containing each contact_id drops removed links.
-- then ensures the base model contains only one row per key

select * except (rownum) from
(
select
    *,
    row_number() over (partition by fact_id, contact_id order by _cta_loaded_at desc) as rownum
from (
    select *
    from {{ ref('fact_contacts_ab1') }}
    where true
    qualify _extracted_at = max(_extracted_at) over (partition by contact_id)
)
)
where rownum = 1
