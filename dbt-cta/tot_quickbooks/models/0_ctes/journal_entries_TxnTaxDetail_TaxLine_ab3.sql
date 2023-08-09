{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('journal_entries_TxnTaxDetail_TaxLine_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_TxnTaxDetail_hashid',
        'DetailType',
        object_to_string('TaxLineDetail'),
        'Amount',
    ]) }} as _airbyte_TaxLine_hashid,
    tmp.*
from {{ ref('journal_entries_TxnTaxDetail_TaxLine_ab2') }} tmp
-- TaxLine at journal_entries/TxnTaxDetail/TaxLine
where 1 = 1

