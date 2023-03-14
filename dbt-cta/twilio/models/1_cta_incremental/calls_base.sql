{{ config(
    unique_key = 'sid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('calls_ab3') }}
select
    {{ adapter.quote('to') }},
    sid,
    uri,
    {{ adapter.quote('from') }},
    price,
    status,
    duration,
    end_time,
    direction,
    group_sid,
    trunk_sid,
    annotation,
    price_unit,
    queue_time,
    start_time,
    account_sid,
    answered_by,
    api_version,
    caller_name,
    date_created,
    date_updated,
    to_formatted,
    forwarded_from,
    from_formatted,
    parent_call_sid,
    phone_number_sid,
    subresource_uris
from {{ ref('calls_ab3') }}
where 1 = 1

