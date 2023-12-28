select *
from {{ source('cta', 'customer_groups_base') }}
