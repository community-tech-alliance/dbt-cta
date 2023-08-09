{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchase_orders_Line_ItemBasedExpenseLineDetail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_Line_hashid',
        'UnitPrice',
        object_to_string('ClassRef'),
        object_to_string('TaxCodeRef'),
        'BillableStatus',
        'Qty',
        object_to_string('ItemRef'),
        object_to_string('CustomerRef'),
    ]) }} as _airbyte_ItemBasedExpenseLineDetail_hashid,
    tmp.*
from {{ ref('purchase_orders_Line_ItemBasedExpenseLineDetail_ab2') }} tmp
-- ItemBasedExpenseLineDetail at purchase_orders/Line/ItemBasedExpenseLineDetail
where 1 = 1

