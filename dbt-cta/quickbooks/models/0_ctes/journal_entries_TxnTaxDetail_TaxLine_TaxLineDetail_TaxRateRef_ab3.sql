{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('journal_entries_TxnTaxDetail_TaxLine_TaxLineDetail_TaxRateRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_TaxLineDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_TaxRateRef_hashid,
    tmp.*
from {{ ref('journal_entries_TxnTaxDetail_TaxLine_TaxLineDetail_TaxRateRef_ab2') }} as tmp
-- TaxRateRef at journal_entries/TxnTaxDetail/TaxLine/TaxLineDetail/TaxRateRef
where 1 = 1
