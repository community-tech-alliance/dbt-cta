select
    id,
    text,
    title,
    email_id,
    created_at,
    field_type,
    updated_at,
    builder_html,
    builder_json
from {{ source('cta','email_fields_base') }}