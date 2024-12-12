select *
from {{ source('cta', 'ads_insights_delivery_device_base') }}
