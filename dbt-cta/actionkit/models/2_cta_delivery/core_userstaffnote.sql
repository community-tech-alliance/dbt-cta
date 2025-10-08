select *
from {{ source('cta', 'core_userstaffnote_base') }}
