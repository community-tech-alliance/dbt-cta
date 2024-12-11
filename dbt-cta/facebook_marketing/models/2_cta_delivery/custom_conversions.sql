select *
from {{ source('cta', 'custom_conversions_base') }}
