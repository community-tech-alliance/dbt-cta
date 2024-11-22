select *
from {{ source('cta', 'twitter_post_analytics_base') }}
