select *
from {{ source('cta','payments_base') }}
