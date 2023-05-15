-- Final base SQL model
-- depends_on: {{ ref('email_config_base') }}
select
  _airbyte_emitted_at,
  id,
  product_id,
  group_id,
  name,
  to_email,
  reply_email,
  primary_role,
  active,
  created_at,
  updated_at
from {{ source('cta', 'email_config_base') }}
-- companies from {{ source('cta', 'email_config_base') }}


