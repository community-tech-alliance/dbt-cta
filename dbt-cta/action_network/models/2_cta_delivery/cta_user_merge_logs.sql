select
    id,
    list_id,
    list_type,
    created_at,
    updated_at,
    merged_user_id,
    removed_user_id,
    merged_user_email,
    removed_user_email,
    _airbyte_user_merge_logs_hashid
from {{ source('cta','user_merge_logs_base') }}
