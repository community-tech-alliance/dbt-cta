{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('message_ab4') }}
select
    is_from_contact,
    campaign_contact_id,
    queued_at,
    created_at,
    media,
    send_before,
    contact_number,
    user_number,
    sent_at,
    assignment_id,
    user_id,
    service,
    service_id,
    send_status,
    messageservice_sid,
    error_code,
    id,
    text,
    service_response_at,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_message_hashid
from {{ ref('message_ab4') }}
where 1=1

