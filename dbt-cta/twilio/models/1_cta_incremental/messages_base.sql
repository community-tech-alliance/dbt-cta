{{ config(
    unique_key = 'sid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('messages_ab3') }}
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
from {{ ref('messages_ab3') }}