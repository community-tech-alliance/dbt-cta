select *
from {{ source('cta', 'core_usermerge_base') }}
