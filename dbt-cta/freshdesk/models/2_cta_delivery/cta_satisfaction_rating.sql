-- Final base SQL model
-- depends_on: {{ ref('satisfaction_rating_base') }}
select
  _airbyte_emitted_at,
  id,
  survey_id,
  agent_id,
  group_id,
  ticket_id,
  feedback,
  created_at,
  updated_at,
  contact_id
from {{ source('cta', 'satisfaction_rating_base') }}
-- companies from {{ source('cta', 'satisfaction_rating_base') }}


