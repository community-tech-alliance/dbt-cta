select
    id,
    name,
    uuid,
    notes,
    hidden,
    owner_id,
    created_at,
    owner_type,
    syndicated,
    updated_at,
    validation_regexp,
    validation_description,
    _airbyte_field_names_hashid
from {{ source('cta','field_names_base') }}
