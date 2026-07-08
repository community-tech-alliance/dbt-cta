select *
from {{ source('cta', 'phone_verification_chats_base') }}
