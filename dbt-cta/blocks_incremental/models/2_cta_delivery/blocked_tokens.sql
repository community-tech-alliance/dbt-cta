select *
from {{ source('cta', 'blocked_tokens_base') }}
