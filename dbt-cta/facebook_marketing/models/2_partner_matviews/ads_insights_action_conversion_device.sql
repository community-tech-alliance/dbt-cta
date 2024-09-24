select *
from {{ source('cta', 'ads_insights_action_conversion_device_base') }}
