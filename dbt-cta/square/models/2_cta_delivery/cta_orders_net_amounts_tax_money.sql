select *
from {{ source('cta','orders_net_amounts_tax_money_base') }}
