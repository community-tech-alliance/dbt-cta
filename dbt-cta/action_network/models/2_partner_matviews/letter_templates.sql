select
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
    image_attribution,
    _airbyte_letter_templates_hashid
from {{ ref('letter_templates_base') }}