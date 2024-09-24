select *
from {{ source('cta', 'ads_insights_region_base') }}
