select *
from {{ source('cta', 'ads_insights_demographics_comscore_market_region_base') }}
