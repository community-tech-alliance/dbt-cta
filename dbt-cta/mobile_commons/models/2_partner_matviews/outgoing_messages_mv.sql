select *
from {{ source('cta', 'outgoing_messages_base') }}
