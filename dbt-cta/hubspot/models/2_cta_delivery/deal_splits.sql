select *
from {{ source('cta', 'deal_splits_base') }}
