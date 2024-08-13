{{ config(
    unique_key = 'sid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('recordings_ab3') }}
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
    encryption_details
from {{ ref('recordings_ab3') }}
