select *
from {{ source('cta','orders_tenders_base') }}
