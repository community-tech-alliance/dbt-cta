select *
from {{ source('cta', 'four_weekly_active_users_base') }}
