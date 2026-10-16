-- forms is a daily snapshot, so only rows in the latest snapshot for each feed are current
-- then ensures the base model contains only one row per primary key (rows can be shared across feeds)

select * except (rownum) from
(
select
    *,
    row_number() over (partition by id order by _extracted_at desc, _cta_loaded_at desc) as rownum
from (
    select *
    from {{ ref('forms_ab1') }}
    where true
    qualify _extracted_at = max(_extracted_at) over (partition by _feed_prefix)
)
)
where rownum = 1
