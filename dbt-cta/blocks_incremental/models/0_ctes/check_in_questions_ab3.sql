{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('check_in_questions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        boolean_to_string('archived'),
        'check_in_id',
        'turf_id',
        'id',
        'text',
        'position',
    ]) }} as _airbyte_check_in_questions_hashid,
    tmp.*
from {{ ref('check_in_questions_ab2') }} as tmp
-- check_in_questions
where 1 = 1
