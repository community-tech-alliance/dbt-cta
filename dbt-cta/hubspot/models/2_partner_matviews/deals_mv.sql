select *
from {{ source('cta', 'deals_base') }}
