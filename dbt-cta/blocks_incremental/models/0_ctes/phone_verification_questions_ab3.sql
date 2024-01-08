{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_verification_questions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'question',
        'updated_at',
        boolean_to_string('active'),
        'created_at',
        'id',
    ]) }} as _airbyte_phone_verification_questions_hashid,
    tmp.*
from {{ ref('phone_verification_questions_ab2') }} as tmp
-- phone_verification_questions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

