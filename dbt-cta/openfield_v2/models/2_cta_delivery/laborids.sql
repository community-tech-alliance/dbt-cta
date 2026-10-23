select *
from {{ source('cta', 'laborids_base') }}
