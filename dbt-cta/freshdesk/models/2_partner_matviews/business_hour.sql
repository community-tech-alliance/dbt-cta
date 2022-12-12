-- Final base SQL model
-- depends_on: {{ ref('business_hour_base') }}
select
  id,
  name,
  description,
  created_at,
  updated_at
from {{ source('cta', 'business_hour_base') }}
-- companies from {{ source('cta', 'business_hour_base') }}