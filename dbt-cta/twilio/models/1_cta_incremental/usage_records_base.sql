{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
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
-- usage_records from {{ source('cta', '_airbyte_raw_usage_records') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

