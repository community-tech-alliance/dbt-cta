{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('sms_unsubscriptions_ab4') }}
select
    id,
    reason,
    user_id,
    owner_id,
    processed,
    source_id,
    created_at,
    owner_type,
    updated_at,
    source_type,
    mobile_message_stat_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sms_unsubscriptions_hashid
from {{ ref('sms_unsubscriptions_ab4') }}