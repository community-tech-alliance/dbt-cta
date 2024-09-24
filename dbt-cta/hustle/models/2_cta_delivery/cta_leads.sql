select *
from {{ source('cta','leads_base') }}
