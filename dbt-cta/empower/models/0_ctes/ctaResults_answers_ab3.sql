{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctaresults_answers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_ctaresults_hashid',
        '_11',
        '_1',
        '_10',
    ]) }} as _airbyte_answers_hashid,
    tmp.*
from {{ ref('ctaresults_answers_ab2') }} tmp
-- answers at ctaresults/answers
where 1 = 1

