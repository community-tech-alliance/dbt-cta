select *
from {{ source('cta', 'core_alloweduserfield_base') }}
