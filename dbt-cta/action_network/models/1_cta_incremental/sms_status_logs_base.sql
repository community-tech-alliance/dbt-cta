{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('sms_status_logs_ab4') }}
select
    id,
    status,
    user_id,
    group_id,
    new_user,
    processed,
    created_at,
    sms_opt_in,
    updated_at,
    subscriber_id,
    subscription_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sms_status_logs_hashid
from {{ ref('sms_status_logs_ab4') }}