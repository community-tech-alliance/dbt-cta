select *
from {{ source('cta', 'phone_banking_questions_base') }}
