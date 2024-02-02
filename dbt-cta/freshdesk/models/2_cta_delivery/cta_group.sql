-- Final base SQL model
-- depends_on: {{ ref('group_base') }}
select
  _airbyte_emitted_at,
  id,
  escalate_to,
  business_hour_id,
  name,
  description,
  unassigned_for,
  created_at,
  updated_at,
  auto_ticket_assign
from {{ source('cta', 'group_base') }}
-- companies from {{ source('cta', 'group_base') }}


