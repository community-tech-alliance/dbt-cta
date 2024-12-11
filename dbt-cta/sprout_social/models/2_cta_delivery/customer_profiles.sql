select *
from {{ source('cta', 'customer_profiles_base') }}
