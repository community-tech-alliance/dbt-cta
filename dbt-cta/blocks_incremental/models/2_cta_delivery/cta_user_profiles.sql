select *
from {{ source('cta', 'user_profiles_base') }}
