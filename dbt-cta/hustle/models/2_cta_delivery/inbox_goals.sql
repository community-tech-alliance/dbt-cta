select *
from {{ source('cta','inbox_goals_base') }}
