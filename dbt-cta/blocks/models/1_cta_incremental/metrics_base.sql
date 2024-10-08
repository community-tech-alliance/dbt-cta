{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('metrics_ab3') }}
select
    updated_at,
    name,
    metric_type,
    created_at,
    id,
    label,
    show_on_leaderboard,
    required,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_metrics_hashid
from {{ ref('metrics_ab3') }}
-- metrics from {{ source('cta', '_airbyte_raw_metrics') }}
