select
  id,
  name,
  status,
  list_size,
  created_at,
  created_by,
  updated_at,
  num_invalid,
  organization_id,
  _cta_loaded_at
from {{ source('cta', 'opt_out_lists_base') }}
