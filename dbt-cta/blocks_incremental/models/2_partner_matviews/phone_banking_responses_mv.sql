select *
from {{ source('cta', 'phone_banking_responses_base') }}
