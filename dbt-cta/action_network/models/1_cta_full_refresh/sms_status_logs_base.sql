{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('sms_status_logs_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sms_status_logs_hashid
from {{ ref('sms_status_logs_ab3') }}
-- sms_status_logs from {{ source('cta', '_airbyte_raw_sms_status_logs') }}
where 1 = 1

