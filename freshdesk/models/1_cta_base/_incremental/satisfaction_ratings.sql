{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('satisfaction_ratings_ab3') }}
select
    id,
    ratings,
    user_id,
    agent_id,
    feedback,
    group_id,
    survey_id,
    ticket_id,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_satisfaction_ratings_hashid
from {{ ref('satisfaction_ratings_ab3') }}
-- satisfaction_ratings from {{ source('cta', '_airbyte_raw_satisfaction_ratings') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

