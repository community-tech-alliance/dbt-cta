-- Final base SQL model
-- depends_on: {{ ref('conversation_base') }}
select
  _airbyte_emitted_at,
  ticket_id,
  id,
  body_text,
  body,
  incoming,
  support_email,
  source,
  created_at,
  updated_at,
  from_email,
  contact_id,
  private
from {{ source('cta', 'conversation_base') }}
-- companies from {{ source('cta', 'conversation_base') }}


