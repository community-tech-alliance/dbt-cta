select *
from {{ source('cta', 'ads_insights_demographics_country_base') }}
