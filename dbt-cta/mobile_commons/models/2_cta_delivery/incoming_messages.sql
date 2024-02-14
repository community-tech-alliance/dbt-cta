select *
from {{ source('cta', 'incoming_messages_base') }}
