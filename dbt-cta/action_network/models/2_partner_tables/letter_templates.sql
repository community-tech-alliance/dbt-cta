select
    _airbyte_emitted_at,
    id,
    tips,
    message,
    subject,
    targets,
    can_edit,
    editable,
    variants,
    letter_id,
    created_at,
    updated_at,
    image_attribution
from {{ source('cta','letter_templates_base') }}