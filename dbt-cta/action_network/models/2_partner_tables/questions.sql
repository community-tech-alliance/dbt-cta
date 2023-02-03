select
    id,
    key,
    name,
    uuid,
    notes,
    hidden,
    user_id,
    group_id,
    settings,
    created_at,
    field_type,
    updated_at,
    parent_group_id,
    question_hidden,
    sent_to_children,
    originating_system
from {{ source('cta','questions_base') }}