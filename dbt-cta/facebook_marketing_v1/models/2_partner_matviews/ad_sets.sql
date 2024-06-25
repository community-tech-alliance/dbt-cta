select *
from {{ source('cta', 'ad_sets_base') }}
