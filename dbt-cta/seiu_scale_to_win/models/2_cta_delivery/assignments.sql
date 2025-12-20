select
  id,
  user_id,
  created_at,
  updated_at,
  campaign_id,
  dynamic_replies,
  dynamic_initials,
  _cta_loaded_at
from {{ source('cta', 'assignments_base') }}
