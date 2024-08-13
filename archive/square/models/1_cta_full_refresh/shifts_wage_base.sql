{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('shifts_wage_ab3') }}
select
    _airbyte_shifts_hashid,
    title,
    hourly_rate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_wage_hashid
from {{ ref('shifts_wage_ab3') }}
-- wage at shifts/wage from {{ ref('shifts') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
