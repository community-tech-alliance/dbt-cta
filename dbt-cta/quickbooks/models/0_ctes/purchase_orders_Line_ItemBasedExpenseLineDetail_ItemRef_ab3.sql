{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchase_orders_Line_ItemBasedExpenseLineDetail_ItemRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_ItemBasedExpenseLineDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_ItemRef_hashid,
    tmp.*
from {{ ref('purchase_orders_Line_ItemBasedExpenseLineDetail_ItemRef_ab2') }} as tmp
-- ItemRef at purchase_orders/Line/ItemBasedExpenseLineDetail/ItemRef
where 1 = 1
