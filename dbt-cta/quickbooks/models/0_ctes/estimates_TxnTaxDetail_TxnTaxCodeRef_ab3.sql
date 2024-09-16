{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('estimates_TxnTaxDetail_TxnTaxCodeRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_TxnTaxDetail_hashid',
        'value',
    ]) }} as _airbyte_TxnTaxCodeRef_hashid,
    tmp.*
from {{ ref('estimates_TxnTaxDetail_TxnTaxCodeRef_ab2') }} as tmp
-- TxnTaxCodeRef at estimates/TxnTaxDetail/TxnTaxCodeRef
where 1 = 1
