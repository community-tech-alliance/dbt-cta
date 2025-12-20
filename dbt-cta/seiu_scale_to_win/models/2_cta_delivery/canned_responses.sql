select
  id,
  text,
  title,
  created_at,
  deleted_at,
  campaign_id,
  _cta_loaded_at
from {{ source('cta', 'canned_responses_base') }}
