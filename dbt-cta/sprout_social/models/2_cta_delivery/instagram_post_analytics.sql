select *
from {{ source('cta', 'instagram_post_analytics_base') }}
