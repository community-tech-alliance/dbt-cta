{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('action_questions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'required',
        'action_id',
        'created_at',
        'updated_at',
        'action_type',
        'custom_json',
        'question_id',
    ]) }} as _airbyte_action_questions_hashid,
    tmp.*
from {{ ref('action_questions_ab2') }} as tmp
-- action_questions
where 1 = 1
