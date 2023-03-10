{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'sid',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('alerts_ab3') }}
select
    sid,
    url,
    log_level,
    more_info,
    alert_text,
    error_code,
    account_sid,
    api_version,
    request_url,
    service_sid,
    date_created,
    date_updated,
    resource_sid,
    date_generated,
    request_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_alerts_hashid
from {{ ref('alerts_ab3') }}
-- alerts from {{ source('cta', '_airbyte_raw_alerts') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

