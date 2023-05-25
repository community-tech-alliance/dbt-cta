select
    id,
    required,
    action_id,
    created_at,
    updated_at,
    action_type,
    custom_json,
    question_id,
    _airbyte_action_questions_hashid
from {{ ref('action_questions_base') }}