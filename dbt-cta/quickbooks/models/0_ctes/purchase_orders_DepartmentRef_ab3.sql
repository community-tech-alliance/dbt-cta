{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchase_orders_DepartmentRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_purchase_orders_hashid',
        'name',
        'value',
    ]) }} as _airbyte_DepartmentRef_hashid,
    tmp.*
from {{ ref('purchase_orders_DepartmentRef_ab2') }} as tmp
-- DepartmentRef at purchase_orders/DepartmentRef
where 1 = 1
