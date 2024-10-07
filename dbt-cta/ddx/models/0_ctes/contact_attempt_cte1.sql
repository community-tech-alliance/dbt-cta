-- CTE:
-- casts fields to data types
-- creates _cta_hash_id

select
    cast(person_id as string) as person_id,
    cast(record_id as string) as record_id,
    cast(state_code as string) as state_code,
    cast(contact_type_name as string) as contact_type_name,
    cast(contact_result_name as string) as contact_result_name,
    cast(datetime_pulled as timestamp) as datetime_pulled,
    cast(datetime_window_start as timestamp) as datetime_window_start,
    cast(datetime_window_end as timestamp) as datetime_window_end,
    cast(_cta_loaded_at as timestamp) as _cta_loaded_at,
  {{ dbt_utils.surrogate_key([
    'person_id',
    'record_id'
  ]) }} as _cta_hash_id
from {{ source('cta', '_contact_attempt_raw') }}
