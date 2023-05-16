select
    _airbyte_emitted_at,
    id,
    list_id,
    list_type,
    created_at,
    updated_at,
    merged_user_id,
    removed_user_id,
    merged_user_email,
    removed_user_email
from {{ source('cta','user_merge_logs_1_base') }}