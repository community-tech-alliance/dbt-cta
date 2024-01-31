{{ config(full_refresh=false) }}
select *
from {{ source('cta','discounts_base') }}
