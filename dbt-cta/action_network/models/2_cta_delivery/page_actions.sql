select
    id,
    action_id,
    created_at,
    updated_at,
    action_type,
    page_wrapper_id,
    _airbyte_page_actions_hashid
from {{ source('cta','page_actions_base') }}
