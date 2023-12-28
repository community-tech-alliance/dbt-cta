select *
from {{ source('cta', 'tiktok_profile_analytics_base') }}
