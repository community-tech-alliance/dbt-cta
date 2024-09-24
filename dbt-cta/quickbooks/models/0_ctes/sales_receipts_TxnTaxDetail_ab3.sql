{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sales_receipts_TxnTaxDetail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_sales_receipts_hashid',
        'TotalTax',
    ]) }} as _airbyte_TxnTaxDetail_hashid,
    tmp.*
from {{ ref('sales_receipts_TxnTaxDetail_ab2') }} as tmp
-- TxnTaxDetail at sales_receipts/TxnTaxDetail
where 1 = 1
