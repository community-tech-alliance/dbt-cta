select *
from {{ source('cta', 'ads_insights_demographics_age_base') }}
