select *
from {{ source('cta','orders_line_items_applied_taxes_base') }}
