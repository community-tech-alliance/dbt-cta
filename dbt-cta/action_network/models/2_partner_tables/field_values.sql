select
    id,
    uuid,
    value,
    user_id,
    created_at,
    updated_at,
    field_name_id
from {{ source('cta','field_values_base') }}