select *
from {{ source('cta','orders_net_amounts_discount_money_base') }}
