-- Final base SQL model
-- depends_on: {{ ref('role_base') }}
select
  id,
  name,
  description,
  created_at,
  updated_at,
  {{ adapter.quote('default') }}
from {{ source('cta', 'role_base') }}
-- companies from {{ source('cta', 'role_base') }}


