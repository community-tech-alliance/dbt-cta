select *
from {{ source('cta', 'core_usermerge_users_base') }}
