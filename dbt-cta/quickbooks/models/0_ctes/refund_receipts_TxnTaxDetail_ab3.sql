{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refund_receipts_TxnTaxDetail_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_refund_receipts_hashid',
        'TotalTax',
    ]) }} as _airbyte_TxnTaxDetail_hashid,
    tmp.*
from {{ ref('refund_receipts_TxnTaxDetail_ab2') }} tmp
-- TxnTaxDetail at refund_receipts/TxnTaxDetail
where 1 = 1

