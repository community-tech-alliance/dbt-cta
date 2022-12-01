{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('shifts_breaks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_shifts_hashid',
        'id',
        'name',
        'end_at',
        boolean_to_string('is_paid'),
        'start_at',
        'break_type_id',
        'expected_duration',
    ]) }} as _airbyte_breaks_hashid,
    tmp.*
from {{ ref('shifts_breaks_ab2') }} tmp
-- breaks at shifts/breaks
where 1 = 1

