{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctas_questions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_ctas_hashid',
        'surveyQuestionVanId',
        array_to_string('values'),
        array_to_string('options'),
        'text',
        'type',
        'key',
    ]) }} as _airbyte_questions_hashid,
    tmp.*
from {{ ref('ctas_questions_ab2') }} tmp
-- questions at ctas/questions
where 1 = 1

