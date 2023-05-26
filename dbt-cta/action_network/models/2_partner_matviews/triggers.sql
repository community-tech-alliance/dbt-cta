select
    id,
    uuid,
    title,
    step_id,
    group_id,
    ladder_id,
    permalink,
    created_at,
    updated_at,
    webhook_id,
    action_type,
    trigger_type,
    exclude_uploads,
    only_text_to_join,
    _airbyte_triggers_hashid
from {{ source('cta','triggers_base') }}