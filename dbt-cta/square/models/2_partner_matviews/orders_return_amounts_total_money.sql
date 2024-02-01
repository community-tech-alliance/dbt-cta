select *
from {{ source('cta','orders_return_amounts_total_money_base') }}
