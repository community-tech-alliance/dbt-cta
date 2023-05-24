select
    id,
    uuid,
    value,
    user_id,
    created_at,
    updated_at,
    field_name_id,
    _airbyte_field_values_hashid
from {{ ref('field_values_base') }}