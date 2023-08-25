{{ config(full_refresh=false) }}
select *
from {{ source('cta','team_member_wages_base') }}
