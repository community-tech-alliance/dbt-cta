-- Final base SQL model
-- depends_on: {{ ref('time_entries_base') }}
select
  id,
  agent_id,
  ticket_id,
  company_id,
  billable,
  note,
  timer_running,
  time_spent,
  created_at,
  updated_at,
  executed_at,
  start_time
from {{ ref('time_entries_base') }}
-- companies from {{ source('cta', 'time_entries_base') }}


