{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('shift_times_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'end_time',
        'shift_id',
        'created_at',
        'start_time',
        'updated_at',
        'day_of_week',
    ]) }} as _airbyte_shift_times_hashid,
    tmp.*
from {{ ref('shift_times_ab2') }} as tmp
-- shift_times
where 1 = 1
