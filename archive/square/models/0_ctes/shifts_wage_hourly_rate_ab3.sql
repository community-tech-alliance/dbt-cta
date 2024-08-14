{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('shifts_wage_hourly_rate_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_wage_hashid',
        'amount',
        'currency',
    ]) }} as _airbyte_hourly_rate_hashid,
    tmp.*
from {{ ref('shifts_wage_hourly_rate_ab2') }} as tmp
-- hourly_rate at shifts/wage/hourly_rate
where 1 = 1
