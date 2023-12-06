select *
from {{ source('cta','daily_active_users_base') }}
