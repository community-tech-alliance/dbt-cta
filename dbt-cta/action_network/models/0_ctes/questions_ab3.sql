{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('questions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'key',
        'name',
        'uuid',
        'notes',
        'hidden',
        'user_id',
        'group_id',
        'settings',
        'created_at',
        'field_type',
        'updated_at',
        'parent_group_id',
        'question_hidden',
        'sent_to_children',
        'originating_system',
    ]) }} as _airbyte_questions_hashid,
    tmp.*
from {{ ref('questions_ab2') }} as tmp
-- questions
where 1 = 1
