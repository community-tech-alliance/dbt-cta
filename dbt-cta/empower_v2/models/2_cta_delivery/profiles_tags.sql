select *
from {{ source('cta', 'profiles_tags_base') }}
