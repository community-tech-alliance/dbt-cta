{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('steps_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'rules',
        'ladder_id',
        'step_type',
        'created_at',
        'updated_at',
        'next_step_id',
        'alternate_next_step_id',
    ]) }} as _airbyte_steps_hashid,
    tmp.*
from {{ ref('steps_ab2') }} tmp
-- steps
where 1 = 1

