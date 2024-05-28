{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_merge_logs_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_merge_logs_hashid
from {{ ref('user_merge_logs_ab4') }}
