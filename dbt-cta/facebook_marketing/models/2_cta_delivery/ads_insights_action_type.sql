select *
from {{ source('cta', 'ads_insights_action_type_base') }}
