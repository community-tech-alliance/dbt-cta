{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sales_receipts_Line_SalesItemLineDetail_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_Line_hashid',
        'UnitPrice',
        object_to_string('TaxCodeRef'),
        'Qty',
        object_to_string('ItemRef'),
    ]) }} as _airbyte_SalesItemLineDetail_hashid,
    tmp.*
from {{ ref('sales_receipts_Line_SalesItemLineDetail_ab2') }} tmp
-- SalesItemLineDetail at sales_receipts/Line/SalesItemLineDetail
where 1 = 1

