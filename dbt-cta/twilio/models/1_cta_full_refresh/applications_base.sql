{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    partitions=partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_applications_hashid',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('applications_ab4') }}
select
    sid,
    uri,
    sms_url,
    voice_url,
    sms_method,
    account_sid,
    api_version,
    date_created,
    date_updated,
    voice_method,
    friendly_name,
    status_callback,
    sms_fallback_url,
    voice_fallback_url,
    sms_fallback_method,
    sms_status_callback,
    voice_fallback_method,
    status_callback_method,
    voice_caller_id_lookup,
    message_status_callback,
    public_application_connect_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_applications_hashid
from {{ ref('applications_ab4') }}
-- applications from {{ source('cta', '_airbyte_raw_applications') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

