{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_returns_return_line_items_total_money_base') }}