{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_total_tax_money_base') }}
