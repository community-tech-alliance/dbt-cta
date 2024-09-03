select *
from {{ source('cta','orders_total_discount_money_base') }}
