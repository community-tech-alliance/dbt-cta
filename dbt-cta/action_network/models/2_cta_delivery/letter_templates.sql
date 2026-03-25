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
    hide_signer_personal_information,
    _airbyte_letter_templates_hashid
from {{ source('cta','letter_templates_base') }}
