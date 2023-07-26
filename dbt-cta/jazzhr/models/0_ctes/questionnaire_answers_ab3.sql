{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('questionnaire_answers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'questionnaire_id',
        'questionnaire_code',
        'answer_value_00',
        'time_taken',
        'applicant_id',
        'answer_value_03',
        'answer_value_04',
        'job_id',
        'answer_value_01',
        'answer_correct_01',
        'answer_value_02',
        'answer_correct_00',
        'answer_correct_03',
        'answer_correct_02',
        'answer_correct_04',
        'date_taken',
    ]) }} as _airbyte_questionnaire_answers_hashid,
    tmp.*
from {{ ref('questionnaire_answers_ab2') }} tmp
-- questionnaire_answers
where 1 = 1

