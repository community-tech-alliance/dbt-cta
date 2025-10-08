select *
from {{ source('cta', 'core_user_base') }}
