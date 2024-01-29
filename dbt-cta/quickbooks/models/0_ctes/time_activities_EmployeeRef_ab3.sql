{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('time_activities_EmployeeRef_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_time_activities_hashid',
        'name',
        'value',
    ]) }} as _airbyte_EmployeeRef_hashid,
    tmp.*
from {{ ref('time_activities_EmployeeRef_ab2') }} tmp
-- EmployeeRef at time_activities/EmployeeRef
where 1 = 1

