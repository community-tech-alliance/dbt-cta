select *
from {{ source('cta', 'ads_insights_age_and_gender_base') }}
