{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('mobile_message_stats_ab3') }}
select
    id,
    stats,
    header,
    created_at,
    updated_at,
    actions_count,
    mobile_message_id,
    mobile_message_field_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_mobile_message_stats_hashid
from {{ ref('mobile_message_stats_ab3') }}
-- mobile_message_stats from {{ source('cta', '_airbyte_raw_mobile_message_stats') }}
where 1 = 1

