select *
from {{ source('cta','tenants_base') }}
