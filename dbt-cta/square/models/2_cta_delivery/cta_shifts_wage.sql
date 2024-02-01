select *
from {{ source('cta','shifts_wage_base') }}
