{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('interaction_step_ab4') }}
select
    answer_actions_data,
    is_deleted,
    question,
    created_at,
    answer_actions,
    id,
    answer_option,
    parent_interaction_id,
    script,
    campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_interaction_step_hashid
from {{ ref('interaction_step_ab4') }}
-- interaction_step from {{ source('cta', '_airbyte_raw_interaction_step') }}
where 1=1

