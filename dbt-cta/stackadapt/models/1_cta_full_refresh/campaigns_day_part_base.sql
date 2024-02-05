{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_day_part_ab4') }}
select
    _airbyte_campaigns_hashid,
    enabled,
    end_hour,
    timezone,
    start_hour,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_day_part_hashid
from {{ ref('campaigns_day_part_ab4') }}
-- day_part at campaigns_base/day_part from {{ ref('campaigns_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

