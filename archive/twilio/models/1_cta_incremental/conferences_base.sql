{{ config(
    unique_key = 'sid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('conferences_ab3') }}
select
    sid,
    uri,
    region,
    status,
    account_sid,
    api_version,
    date_created,
    date_updated,
    friendly_name,
    subresource_uris,
    reason_conference_ended,
    call_sid_ending_conference
from {{ ref('conferences_ab3') }}
