{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('messages_ab5') }}
select
    {{ adapter.quote('to') }},
    sid,
    uri,
    body,
    {{ adapter.quote('from') }},
    price,
    status,
    date_sent,
    direction,
    num_media,
    error_code,
    price_unit,
    account_sid,
    api_version,
    date_created,
    date_updated,
    num_segments,
    error_message,
    subresource_uris,
    messaging_service_sid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_messages_hashid
from {{ ref('messages_ab5') }}
-- messages from {{ source('cta', '_airbyte_raw_messages') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

