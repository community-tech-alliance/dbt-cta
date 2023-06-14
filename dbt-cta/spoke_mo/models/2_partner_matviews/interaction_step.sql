select
    answer_actions_data,
    is_deleted,
    question,
    created_at,
    answer_actions,
    id,
    answer_option,
    parent_interaction_id,
    script,
    campaign_id,
    _airbyte_interaction_step_hashid
from {{ source('cta','interaction_step_base') }}