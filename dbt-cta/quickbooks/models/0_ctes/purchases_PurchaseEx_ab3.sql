{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchases_PurchaseEx_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_purchases_hashid',
        array_to_string(adapter.quote('any')),
    ]) }} as _airbyte_PurchaseEx_hashid,
    tmp.*
from {{ ref('purchases_PurchaseEx_ab2') }} as tmp
-- PurchaseEx at purchases/PurchaseEx
where 1 = 1
