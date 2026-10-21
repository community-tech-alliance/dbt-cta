select *
from {{ source('cta', 'profiles_base') }}
