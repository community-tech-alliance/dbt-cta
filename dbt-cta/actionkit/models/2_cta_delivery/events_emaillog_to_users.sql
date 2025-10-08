select *
from {{ source('cta', 'events_emaillog_to_users_base') }}
