{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tax_agencies_MetaData_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_tax_agencies_hashid',
        'CreateTime',
        'LastUpdatedTime',
    ]) }} as _airbyte_MetaData_hashid,
    tmp.*
from {{ ref('tax_agencies_MetaData_ab2') }} as tmp
-- MetaData at tax_agencies/MetaData
where 1 = 1
