{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('questions_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_questions_hashid
from {{ ref('questions_ab4') }}
