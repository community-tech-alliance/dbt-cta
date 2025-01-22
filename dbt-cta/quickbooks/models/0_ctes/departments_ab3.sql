{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('departments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('ParentRef'),
        'SyncToken',
        boolean_to_string('Active'),
        object_to_string('MetaData'),
        'domain',
        'airbyte_cursor',
        'FullyQualifiedName',
        boolean_to_string('SubDepartment'),
        'Id',
        'Name',
    ]) }} as _airbyte_departments_hashid,
    tmp.*
from {{ ref('departments_ab2') }} as tmp
-- departments
where 1 = 1
