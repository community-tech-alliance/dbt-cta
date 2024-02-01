select *
from {{ source('cta','orders_returns_base') }}
