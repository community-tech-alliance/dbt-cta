select
    *
from {{ source('cta','payroll_base') }}
