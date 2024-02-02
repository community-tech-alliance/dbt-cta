select
    campaign_contact_id,
    created_at,
    id,
    value,
    interaction_step_id,
    _airbyte_emitted_at,
    _airbyte_question_response_hashid
from {{ source('cta','question_response_base') }}