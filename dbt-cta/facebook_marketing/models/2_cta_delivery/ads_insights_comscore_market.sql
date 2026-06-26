select *
from {{ source('cta', 'ads_insights_comscore_market_base') }}
