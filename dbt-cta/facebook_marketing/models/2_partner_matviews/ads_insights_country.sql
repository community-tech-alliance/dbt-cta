select *
from {{ source('cta', 'ads_insights_country_base') }}
