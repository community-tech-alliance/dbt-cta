{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_LinkedTxn_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payments_hashid',
        'TxnId',
        'TxnType',
    ]) }} as _airbyte_LinkedTxn_hashid,
    tmp.*
from {{ ref('payments_LinkedTxn_ab2') }} as tmp
-- LinkedTxn at payments/LinkedTxn
where 1 = 1
