select
  id,
  cell,
  alias,
  email,
  last_name,
  created_at,
  first_name,
  _cta_loaded_at
from {{ source('cta', 'users_base') }}
