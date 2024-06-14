select *
from {{ source('cta', 'documents_phone_banking_phone_banks_base') }}
