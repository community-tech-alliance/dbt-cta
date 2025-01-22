select
    _airbyte_TxnTaxDetail_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_TxnTaxCodeRef_hashid
from {{ source('cta','journal_entries_TxnTaxDetail_TxnTaxCodeRef_base') }}
