select *
from {{ source('cta', 'list_folders_users_base') }}
