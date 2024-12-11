select *
from {{ source('cta', 'ads_insights_delivery_platform_and_device_platform_base') }}
