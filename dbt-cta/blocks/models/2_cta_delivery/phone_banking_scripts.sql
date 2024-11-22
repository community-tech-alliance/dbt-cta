select *
from {{ source('cta', 'phone_banking_scripts_base') }}
