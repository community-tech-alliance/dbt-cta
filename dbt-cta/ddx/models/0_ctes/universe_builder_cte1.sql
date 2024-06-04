-- CTE:
-- casts fields to data types
-- creates _cta_hash_id

select
    cast(person_id as string) as person_id,
    cast(state_code as string) as state_code,
    cast(client_slug as string) as client_slug,
    cast(universe_name as string) as universe_name,
    cast(_cta_loaded_at as timestamp) as _cta_loaded_at,
    cast(subscription_name as string) as subscription_name,
  {{ dbt_utils.surrogate_key([
    'person_id',
    'client_slug'
  ]) }} as _cta_hash_id
from {{ source('cta', '_universe_builder_raw') }}
