{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('action_questions_ab3') }}
select
    id,
    required,
    action_id,
    created_at,
    updated_at,
    action_type,
    custom_json,
    question_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_action_questions_hashid
from {{ ref('action_questions_ab3') }}
-- action_questions from {{ source('cta', '_airbyte_raw_action_questions') }}
where 1 = 1
