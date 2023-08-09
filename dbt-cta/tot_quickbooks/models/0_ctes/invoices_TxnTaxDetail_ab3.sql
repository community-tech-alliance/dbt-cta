{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoices_TxnTaxDetail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_invoices_hashid',
        'TotalTax',
        object_to_string('TxnTaxCodeRef'),
        array_to_string('TaxLine'),
    ]) }} as _airbyte_TxnTaxDetail_hashid,
    tmp.*
from {{ ref('invoices_TxnTaxDetail_ab2') }} tmp
-- TxnTaxDetail at invoices/TxnTaxDetail
where 1 = 1

