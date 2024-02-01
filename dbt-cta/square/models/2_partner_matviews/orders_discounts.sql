select *
from {{ source('cta','orders_discounts_base') }}
