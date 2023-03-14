{{ config(
    unique_key = 'sid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('usage_records_ab3') }}
select
    uri,
    as_of,
    count,
    price,
    usage,
    category,
    end_date,
    count_unit,
    price_unit,
    start_date,
    usage_unit,
    account_sid,
    api_version,
    description,
    subresource_uris,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_usage_records_hashid
from {{ ref('usage_records_ab3') }}

