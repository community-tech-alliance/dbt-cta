select *
from {{ source('cta', 'twitter_profile_analytics_base') }}
