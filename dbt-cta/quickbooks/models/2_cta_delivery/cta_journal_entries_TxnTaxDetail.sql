select
    _airbyte_journal_entries_hashid,
    TotalTax,
    TxnTaxCodeRef,
    TaxLine,
    _airbyte_emitted_at,
    _airbyte_TxnTaxDetail_hashid
from {{ source('cta','journal_entries_TxnTaxDetail_base') }}