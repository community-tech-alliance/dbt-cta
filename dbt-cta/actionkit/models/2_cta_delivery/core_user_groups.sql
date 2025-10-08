select *
from {{ source('cta', 'core_user_groups_base') }}
