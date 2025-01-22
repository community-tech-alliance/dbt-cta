{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('credit_memos_TxnTaxDetail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_credit_memos_hashid',
        'TotalTax',
    ]) }} as _airbyte_TxnTaxDetail_hashid,
    tmp.*
from {{ ref('credit_memos_TxnTaxDetail_ab2') }} as tmp
-- TxnTaxDetail at credit_memos/TxnTaxDetail
where 1 = 1
