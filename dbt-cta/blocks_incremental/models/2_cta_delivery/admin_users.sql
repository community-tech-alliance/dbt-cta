select *
from {{ source('cta', 'admin_users_base') }}
