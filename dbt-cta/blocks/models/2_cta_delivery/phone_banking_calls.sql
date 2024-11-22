select *
from {{ source('cta', 'phone_banking_calls_base') }}
