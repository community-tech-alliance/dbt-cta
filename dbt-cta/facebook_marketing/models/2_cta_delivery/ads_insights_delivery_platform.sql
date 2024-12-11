select *
from {{ source('cta', 'ads_insights_delivery_platform_base') }}
