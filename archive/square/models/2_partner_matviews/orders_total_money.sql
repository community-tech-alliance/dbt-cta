select *
from {{ source('cta','orders_total_money_base') }}
