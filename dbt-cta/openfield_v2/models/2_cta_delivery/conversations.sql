select *
from {{ source('cta', 'conversations_base') }}
