{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctaResults_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'profileEid',
        'ctaId',
        'notes',
        'contactedMts',
        object_to_string('answers'),
        object_to_string('answerIdsByPromptId'),
    ]) }} as _airbyte_ctaResults_hashid,
    tmp.*
from {{ ref('ctaResults_ab2') }} tmp
-- ctaResults
where 1 = 1

