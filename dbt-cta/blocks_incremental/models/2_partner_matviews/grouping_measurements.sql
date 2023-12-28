select *
from {{ source('cta', 'grouping_measurements_base') }}
