select *
from {{ source('cta', 'customer_users_base') }}
