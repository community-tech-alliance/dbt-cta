select
    _airbyte_emitted_at,
    id,
    action_id,
    created_at,
    updated_at,
    action_type,
    page_wrapper_id
from {{ source('cta','page_actions_base') }}