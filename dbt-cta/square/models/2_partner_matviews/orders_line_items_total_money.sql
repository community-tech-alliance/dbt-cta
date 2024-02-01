select *
from {{ source('cta','orders_line_items_total_money_base') }}
