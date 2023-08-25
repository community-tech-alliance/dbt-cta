{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_returns_return_line_items_gross_return_money_base') }}
