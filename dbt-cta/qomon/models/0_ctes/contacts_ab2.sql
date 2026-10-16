-- ensures the base model contains only one row per primary key
-- Qomon re-sends full rows whenever a contact is touched, so the row from the latest extract wins

select * except (rownum) from
(
select
    *,
    row_number() over (partition by id order by _extracted_at desc, _cta_loaded_at desc) as rownum
from {{ ref('contacts_ab1') }}
)
where rownum = 1
