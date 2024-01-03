select *
from {{ source('cta', 'tiktok_post_analytics_base') }}
