select *
from {{ source('cta', 'conversations_attempts_lookup_base') }}
