select *
from {{ source('cta', 'conversation_code_base') }}
