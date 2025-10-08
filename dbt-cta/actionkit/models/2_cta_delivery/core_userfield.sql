select *
from {{ source('cta', 'core_userfield_base') }}
