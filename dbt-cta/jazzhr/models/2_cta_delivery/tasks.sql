select
    notes,
    date_due,
    owner_id,
    date_created,
    description,
    opener_name,
    object_id,
    assignee_name,
    due_whenever,
    time_created,
    id,
    status,
    assignee_id,
    _airbyte_extracted_at,
    _airbyte_tasks_hashid
from {{ source('cta','tasks_base') }}
