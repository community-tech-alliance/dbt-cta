{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoices_TxnTaxDetail_TaxLine_TaxLineDetail_TaxRateRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_TaxLineDetail_hashid',
        'value',
    ]) }} as _airbyte_TaxRateRef_hashid,
    tmp.*
from {{ ref('invoices_TxnTaxDetail_TaxLine_TaxLineDetail_TaxRateRef_ab2') }} as tmp
-- TaxRateRef at invoices/TxnTaxDetail/TaxLine/TaxLineDetail/TaxRateRef
where 1 = 1
