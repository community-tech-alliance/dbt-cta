select
    _airbyte_emitted_at,
    id,
    required,
    action_id,
    created_at,
    updated_at,
    action_type,
    custom_json,
    question_id
from {{ source('cta','action_questions_base') }}