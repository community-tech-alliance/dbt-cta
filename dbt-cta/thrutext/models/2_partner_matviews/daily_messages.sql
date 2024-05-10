select *
from {{ source('cta', 'daily_messages_base') }}
