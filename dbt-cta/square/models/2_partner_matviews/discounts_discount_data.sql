{{ config(full_refresh=false) }}
select *
from {{ source('cta','discounts_discount_data_base') }}
