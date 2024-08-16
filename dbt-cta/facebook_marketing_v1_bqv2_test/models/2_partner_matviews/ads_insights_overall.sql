select *
from {{ source('cta', 'ads_insights_overall_base') }}
