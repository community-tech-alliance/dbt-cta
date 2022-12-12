-- Final base SQL model
-- depends_on: {{ ref('agent_base') }}
select
  id,
  available,
  occasional,
  signature,
  ticket_scope,
  created_at,
  updated_at,
  available_since,
  contact_active,
  contact_email,
  contact_job_title,
  contact_language,
  contact_last_login_at,
  contact_mobile,
  contact_name,
  contact_phone,
  contact_time_zone,
  contact_created_at,
  contact_updated_at
from {{ source('cta', 'agent_base') }}
-- companies from {{ source('cta', 'agent_base') }}


