select
    id,
    text,
    title,
    email_id,
    created_at,
    field_type,
    updated_at,
    builder_html,
    builder_json,
    _airbyte_email_fields_hashid
from {{ ref('email_fields_base') }}