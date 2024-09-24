{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deposits_Line_LinkedTxn_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_Line_hashid',
        'TxnId',
        'TxnType',
        'TxnLineId',
    ]) }} as _airbyte_LinkedTxn_hashid,
    tmp.*
from {{ ref('deposits_Line_LinkedTxn_ab2') }} as tmp
-- LinkedTxn at deposits/Line/LinkedTxn
where 1 = 1
