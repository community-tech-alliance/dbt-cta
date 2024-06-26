{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('unsubscriptions_ab4') }}
select
    id,
    reason,
    user_id,
    email_id,
    group_id,
    new_user,
    processed,
    created_at,
    subject_id,
    updated_at,
    source_code,
    http_referer,
    custom_fields,
    subscriber_id,
    source_action_id,
    source_action_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_unsubscriptions_hashid
from {{ ref('unsubscriptions_ab4') }}
