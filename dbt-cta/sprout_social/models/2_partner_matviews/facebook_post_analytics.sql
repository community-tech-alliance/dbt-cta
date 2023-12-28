select *
from {{ source('cta', 'facebook_post_analytics_base') }}
