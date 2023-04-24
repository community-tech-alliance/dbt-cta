{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctaresults_answeridsbypromptid_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_ctaresults_hashid',
        array_to_string('_13805'),
        array_to_string('_13198'),
        array_to_string('_13683'),
        array_to_string('_13197'),
        array_to_string('_13684'),
        array_to_string('_13800'),
        array_to_string('_13303'),
        array_to_string('_13304'),
    ]) }} as _airbyte_answeridsbypromptid_hashid,
    tmp.*
from {{ ref('ctaresults_answeridsbypromptid_ab2') }} tmp
-- answeridsbypromptid at ctaresults/answeridsbypromptid
where 1 = 1

