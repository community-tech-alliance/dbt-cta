select *
from {{ source('cta', 'ads_insights_demographics_gender_base') }}
