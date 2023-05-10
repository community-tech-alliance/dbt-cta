select
    id,
    position,
    action_id,
    created_at,
    updated_at,
    is_optional,
    object_type,
    object_attribute,
    related_object_id,
    default_response_id,
    related_object_type,
    _airbyte_action_fields_hashid
from {{ source('cta','action_fields_base') }}