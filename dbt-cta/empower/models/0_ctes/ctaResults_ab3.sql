{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctaresults_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'profileEid',
        'ctaId',
        'notes',
        'contactedMts',
        object_to_string('answers'),
        object_to_string('answeridsbypromptid'),
    ]) }} as _airbyte_ctaresults_hashid,
    tmp.*
from {{ ref('ctaresults_ab2') }} tmp
-- ctaresults
where 1 = 1

