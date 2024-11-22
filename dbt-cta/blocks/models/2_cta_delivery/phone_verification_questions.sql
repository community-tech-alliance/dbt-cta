select *
from {{ source('cta', 'phone_verification_questions_base') }}
