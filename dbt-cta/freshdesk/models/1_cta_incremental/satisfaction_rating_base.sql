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
-- depends_on: {{ ref('satisfaction_ratings_ab2') }}
select
    id,
    survey_id,
    agent_id,
    group_id,
    ticket_id,
    feedback,
    SAFE_CAST(created_at as timestamp) as created_at,
    SAFE_CAST(updated_at as timestamp) as updated_at,
    user_id as contact_id,
    ratings,
    _airbyte_ab_id,
    _airbyte_emitted_at,
from {{ ref('satisfaction_ratings_ab2') }}
-- satisfaction_ratings from {{ source('cta', '_airbyte_raw_satisfaction_ratings') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

