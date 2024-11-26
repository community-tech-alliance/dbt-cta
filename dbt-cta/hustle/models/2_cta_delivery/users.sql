select *
from {{ source('cta','users_base') }}
