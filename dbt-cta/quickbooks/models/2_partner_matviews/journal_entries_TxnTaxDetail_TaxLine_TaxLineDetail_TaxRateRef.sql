select
    _airbyte_TaxLineDetail_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_TaxRateRef_hashid
from {{ source('cta','journal_entries_TxnTaxDetail_TaxLine_TaxLineDetail_TaxRateRef_base') }}
