{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
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
    subresource_uris,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_calls_hashid
from {{ ref('calls_ab3') }}
-- calls from {{ source('cta', '_airbyte_raw_calls') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

