{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctas_prompts_answers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_prompts_hashid',
        'vanId',
        boolean_to_string('isDeleted'),
        'answerText',
        'ordering',
        'promptId',
        'id',
    ]) }} as _airbyte_answers_hashid,
    tmp.*
from {{ ref('ctas_prompts_answers_ab2') }} tmp
-- answers at ctas/prompts/answers
where 1 = 1

