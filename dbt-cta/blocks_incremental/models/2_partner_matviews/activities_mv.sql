select *
from {{ source('cta', 'activities_base') }}
