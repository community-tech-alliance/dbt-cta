{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('shifts_wage_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_shifts_hashid',
        'title',
        object_to_string('hourly_rate'),
    ]) }} as _airbyte_wage_hashid,
    tmp.*
from {{ ref('shifts_wage_ab2') }} as tmp
-- wage at shifts/wage
where 1 = 1
