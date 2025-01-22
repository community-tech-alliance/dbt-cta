{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('employees_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'HiredDate',
        boolean_to_string('Organization'),
        'FamilyName',
        boolean_to_string('BillableTime'),
        'GivenName',
        'Gender',
        object_to_string('MetaData'),
        'DisplayName',
        object_to_string('PrimaryAddr'),
        object_to_string('PrimaryEmailAddr'),
        object_to_string('PrimaryPhone'),
        'PrintOnCheckName',
        'airbyte_cursor',
        'EmployeeNumber',
        'Title',
        'MiddleName',
        object_to_string('Mobile'),
        'SyncToken',
        boolean_to_string('Active'),
        'Suffix',
        boolean_to_string('sparse'),
        'domain',
        'BillRate',
        'Id',
        'ReleasedDate',
        'BirthDate',
    ]) }} as _airbyte_employees_hashid,
    tmp.*
from {{ ref('employees_ab2') }} as tmp
-- employees
where 1 = 1
