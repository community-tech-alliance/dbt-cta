select *
from {{ source('cta', 'phone_banking_answer_options_base') }}
