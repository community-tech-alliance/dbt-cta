select *
from {{ source('cta','orders_discounts_applied_money_base') }}
