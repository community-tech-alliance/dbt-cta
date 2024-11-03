select *
from {{ source('cta', 'district_types_base') }}
