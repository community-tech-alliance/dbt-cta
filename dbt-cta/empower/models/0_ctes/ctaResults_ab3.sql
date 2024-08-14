{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctaResults_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'profileEid',
        'ctaId',
        'notes',
        'contactedMts',
        object_to_string('answers'),
        object_to_string('answerIdsByPromptId'),
    ]) }} as _airbyte_ctaResults_hashid,
    tmp.*
from {{ ref('ctaResults_ab2') }} as tmp
-- ctaResults
where 1 = 1
