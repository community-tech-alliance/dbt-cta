{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctaResults_answerIdsByPromptId_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_ctaResults_hashid',
        array_to_string('_13805'),
        array_to_string('_13198'),
        array_to_string('_13683'),
        array_to_string('_13197'),
        array_to_string('_13684'),
        array_to_string('_13800'),
        array_to_string('_13303'),
        array_to_string('_13304'),
    ]) }} as _airbyte_answerIdsByPromptId_hashid,
    tmp.*
from {{ ref('ctaResults_answerIdsByPromptId_ab2') }} tmp
-- answerIdsByPromptId at ctaResults/answerIdsByPromptId
where 1 = 1

