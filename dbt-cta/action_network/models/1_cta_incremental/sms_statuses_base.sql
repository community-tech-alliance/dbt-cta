{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('sms_statuses_ab4') }}
select
    id,
    status,
    user_id,
    group_id,
    join_date,
    created_at,
    updated_at,
    subscriber_id,
    source_action_id,
    source_action_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sms_statuses_hashid
from {{ ref('sms_statuses_ab4') }}