select *
from {{ source('cta', 'instagram_profile_analytics_base') }}
