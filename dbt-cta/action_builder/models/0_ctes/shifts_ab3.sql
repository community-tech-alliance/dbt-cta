{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('shifts_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'timezone',
        'target_id',
        'created_at',
        'updated_at',
        'target_type',
        'created_by_id',
        'deleted_by_id',
    ]) }} as _airbyte_shifts_hashid,
    tmp.*
from {{ ref('shifts_ab2') }} as tmp
-- shifts
where 1 = 1
