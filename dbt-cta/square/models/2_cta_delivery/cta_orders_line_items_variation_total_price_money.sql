select *
from {{ source('cta','orders_line_items_variation_total_price_money_base') }}
