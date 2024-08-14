select *
from {{ source('cta','taxes_base') }}
