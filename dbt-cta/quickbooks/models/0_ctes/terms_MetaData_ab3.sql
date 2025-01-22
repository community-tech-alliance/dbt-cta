{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('terms_MetaData_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_terms_hashid',
        'CreateTime',
        'LastUpdatedTime',
    ]) }} as _airbyte_MetaData_hashid,
    tmp.*
from {{ ref('terms_MetaData_ab2') }} as tmp
-- MetaData at terms/MetaData
where 1 = 1
