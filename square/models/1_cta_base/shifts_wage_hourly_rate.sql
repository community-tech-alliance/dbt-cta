{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('shifts_wage_hourly_rate_ab3') }}
select
    _airbyte_wage_hashid,
    amount,
    currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_hourly_rate_hashid
from {{ ref('shifts_wage_hourly_rate_ab3') }}
-- hourly_rate at shifts/wage/hourly_rate from {{ ref('shifts_wage') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

