{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('recordings_ab5') }}
select
    sid,
    uri,
    price,
    source,
    status,
    call_sid,
    channels,
    duration,
    media_url,
    error_code,
    price_unit,
    start_time,
    account_sid,
    api_version,
    date_created,
    date_updated,
    conference_sid,
    subresource_uris,
    encryption_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_recordings_hashid
from {{ ref('recordings_ab5') }}
-- recordings from {{ source('cta', '_airbyte_raw_recordings') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

