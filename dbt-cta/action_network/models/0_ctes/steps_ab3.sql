{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
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
from {{ ref('steps_ab2') }} as tmp
-- steps
where 1 = 1
