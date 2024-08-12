select *
from {{ source('cta','orders_taxes_base') }}
