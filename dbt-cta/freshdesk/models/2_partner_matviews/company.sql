-- Final base SQL model
-- depends_on: {{ ref('company_base') }}
select
  _airbyte_emitted_at,
  id,
  name,
  note,
  created_at,
  updated_at,
  description,
  custom_member_code,
  custom_secondary_dampt_strategist,
  custom_primary_dampt_strategist,
  custom_pod,
  custom_mini_pod,
  custom_internal_affiliate_list
from {{ source('cta', 'company_base') }}
-- companies from {{ source('cta', 'company_base') }}


