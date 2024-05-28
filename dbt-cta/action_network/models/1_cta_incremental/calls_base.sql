{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('calls_ab4') }}
select
    id,
    city,
    uuid,
    email,
    phone,
    state,
    status,
    street,
    country,
    user_id,
    tag_list,
    zip_code,
    last_name,
    created_at,
    first_name,
    updated_at,
    display_name,
    custom_fields,
    twilio_call_sid,
    call_campaign_id,
    originating_system,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_calls_hashid
from {{ ref('calls_ab4') }}