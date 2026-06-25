select *
from {{ source('cta', 'ad_creatives_from_ads_base') }}
