{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('surveys_questions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_surveys_hashid',
        'id',
        'label',
        boolean_to_string(adapter.quote('default')),
        array_to_string('accepted_ratings'),
    ]) }} as _airbyte_questions_hashid,
    tmp.*
from {{ ref('surveys_questions_ab2') }} tmp
-- questions at surveys/questions
where 1 = 1

