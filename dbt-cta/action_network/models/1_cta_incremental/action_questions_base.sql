{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}

-- Final base SQL model
-- depends_on: {{ ref('action_questions_ab4') }}
select
    id,
    required,
    action_id,
    created_at,
    updated_at,
    action_type,
    custom_json,
    question_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_action_questions_hashid
from {{ ref('action_questions_ab4') }}
