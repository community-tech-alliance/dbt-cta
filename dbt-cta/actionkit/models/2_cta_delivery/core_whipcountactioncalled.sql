select *
from {{ source('cta', 'core_whipcountactioncalled_base') }}
