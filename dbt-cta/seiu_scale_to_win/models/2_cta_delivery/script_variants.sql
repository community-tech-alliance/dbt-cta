select
  id,
  `order`,
  script,
  created_at,
  deleted_at,
  updated_at,
  campaign_id,
  _cta_loaded_at
from {{ source('cta', 'script_variants_base') }}
