{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('questions_ab3') }}
select
    id,
    key,
    name,
    uuid,
    notes,
    hidden,
    user_id,
    group_id,
    settings,
    created_at,
    field_type,
    updated_at,
    parent_group_id,
    question_hidden,
    sent_to_children,
    originating_system,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_questions_hashid
from {{ ref('questions_ab3') }}
-- questions from {{ source('cta', '_airbyte_raw_questions') }}
where 1 = 1

