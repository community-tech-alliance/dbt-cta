select *
from {{ source('cta', 'electoral_districts_base') }}
