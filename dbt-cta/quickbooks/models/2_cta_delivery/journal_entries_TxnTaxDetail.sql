select
    _airbyte_journal_entries_hashid,
    TotalTax,
    TxnTaxCodeRef,
    TaxLine,
    _airbyte_extracted_at,
    _airbyte_TxnTaxDetail_hashid
from {{ source('cta','journal_entries_TxnTaxDetail_base') }}
