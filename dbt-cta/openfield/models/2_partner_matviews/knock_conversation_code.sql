select *
from {{ source('cta','knock_conversation_code_base') }}
