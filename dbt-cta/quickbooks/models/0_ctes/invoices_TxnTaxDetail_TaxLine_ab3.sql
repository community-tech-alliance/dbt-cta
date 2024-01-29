{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoices_TxnTaxDetail_TaxLine_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_TxnTaxDetail_hashid',
        'DetailType',
        object_to_string('TaxLineDetail'),
        'Amount',
    ]) }} as _airbyte_TaxLine_hashid,
    tmp.*
from {{ ref('invoices_TxnTaxDetail_TaxLine_ab2') }} tmp
-- TaxLine at invoices/TxnTaxDetail/TaxLine
where 1 = 1

