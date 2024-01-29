{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_methods_MetaData_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_payment_methods_hashid',
        'CreateTime',
        'LastUpdatedTime',
    ]) }} as _airbyte_MetaData_hashid,
    tmp.*
from {{ ref('payment_methods_MetaData_ab2') }} tmp
-- MetaData at payment_methods/MetaData
where 1 = 1

