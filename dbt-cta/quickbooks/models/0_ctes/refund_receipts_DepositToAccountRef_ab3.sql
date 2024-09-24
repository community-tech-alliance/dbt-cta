{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refund_receipts_DepositToAccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_refund_receipts_hashid',
        'name',
        'value',
    ]) }} as _airbyte_DepositToAccountRef_hashid,
    tmp.*
from {{ ref('refund_receipts_DepositToAccountRef_ab2') }} as tmp
-- DepositToAccountRef at refund_receipts/DepositToAccountRef
where 1 = 1
