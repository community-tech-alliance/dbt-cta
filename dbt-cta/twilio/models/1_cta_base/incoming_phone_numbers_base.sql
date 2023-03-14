{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    partitions=partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('incoming_phone_numbers_ab3') }}
select
    sid,
    uri,
    beta,
    origin,
    status,
    sms_url,
    trunk_sid,
    voice_url,
    bundle_sid,
    sms_method,
    account_sid,
    address_sid,
    api_version,
    capabilities_MMS,
    capabilities_SMS,
    capabilities_voice,
    date_created,
    date_updated,
    identity_sid,
    phone_number,
    voice_method,
    friendly_name,
    status_callback,
    emergency_status,
    sms_fallback_url,
    voice_fallback_url,
    voice_receive_mode,
    sms_application_sid,
    sms_fallback_method,
    address_requirements,
    emergency_address_sid,
    voice_application_sid,
    voice_fallback_method,
    status_callback_method,
    voice_caller_id_lookup,
    emergency_address_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_incoming_phone_numbers_hashid
from {{ ref('incoming_phone_numbers_ab3') }}
-- incoming_phone_numbers from {{ source('cta', '_airbyte_raw_incoming_phone_numbers') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

