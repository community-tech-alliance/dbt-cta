{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_line_items_base') }}