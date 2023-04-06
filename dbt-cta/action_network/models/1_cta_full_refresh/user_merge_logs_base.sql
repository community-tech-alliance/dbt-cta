{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_merge_logs_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_merge_logs_hashid
from {{ ref('user_merge_logs_ab3') }}
-- user_merge_logs from {{ source('cta', '_airbyte_raw_user_merge_logs') }}
where 1 = 1

