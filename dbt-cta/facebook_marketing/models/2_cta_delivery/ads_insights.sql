select *
from {{ source('cta', 'ads_insights_base') }}
