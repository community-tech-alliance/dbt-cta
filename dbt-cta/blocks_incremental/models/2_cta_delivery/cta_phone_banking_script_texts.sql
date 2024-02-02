select *
from {{ source('cta', 'phone_banking_script_texts_base') }}
