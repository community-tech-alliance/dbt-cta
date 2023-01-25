{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_stats_ab3') }}
select
    id,
    stats,
    header,
    email_id,
    created_at,
    total_sent,
    updated_at,
    actions_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_stats_hashid
from {{ ref('email_stats_ab3') }}
-- email_stats from {{ source('cta', '_airbyte_raw_email_stats') }}
where 1 = 1

