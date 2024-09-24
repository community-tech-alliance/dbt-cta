{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('time_activities_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('EmployeeRef'),
        'NameOf',
        'Description',
        'Hours',
        'TxnDate',
        'airbyte_cursor',
        'Minutes',
        'HourlyRate',
        'SyncToken',
        boolean_to_string('sparse'),
        'BillableStatus',
        object_to_string('MetaData'),
        'domain',
        'Id',
        object_to_string('ItemRef'),
        object_to_string('CustomerRef'),
        boolean_to_string('Taxable'),
    ]) }} as _airbyte_time_activities_hashid,
    tmp.*
from {{ ref('time_activities_ab2') }} as tmp
-- time_activities
where 1 = 1
