select *
from {{ source('cta', 'customer_tags_base') }}
