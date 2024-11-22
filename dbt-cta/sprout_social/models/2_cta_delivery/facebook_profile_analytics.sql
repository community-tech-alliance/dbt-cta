select *
from {{ source('cta', 'facebook_profile_analytics_base') }}
