select *
from {{ source('cta','agent_actions_base') }}
