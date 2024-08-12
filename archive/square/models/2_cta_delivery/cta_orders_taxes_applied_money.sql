select *
from {{ source('cta','orders_taxes_applied_money_base') }}
