select *
from {{ source('cta','contact_attempt_base') }}
