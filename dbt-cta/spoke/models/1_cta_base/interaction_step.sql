{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('interaction_step_ab3') }}
select
    id,
    question,
    created_at,
    is_deleted,
    updated_at,
    campaign_id,
    answer_option,
    answer_actions,
    script_options,
    parent_interaction_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_interaction_step_hashid
from {{ ref('interaction_step_ab3') }}
-- interaction_step from {{ source('public', '_airbyte_raw_interaction_step') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

