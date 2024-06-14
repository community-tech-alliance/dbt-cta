select *
from {{ source('cta', 'phone_verification_responses_base') }}
