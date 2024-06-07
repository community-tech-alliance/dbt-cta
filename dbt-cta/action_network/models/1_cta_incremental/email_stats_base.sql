{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_stats_ab4') }}
select
    id,
    stats,
    header,
    email_id,
    created_at,
    total_sent,
    updated_at,
    actions_count,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_stats_hashid
from {{ ref('email_stats_ab4') }}
