select *
from {{ source('cta','team_member_wages_hourly_rate_base') }}
