select *
from {{ source('cta','lead_externals_base') }}
