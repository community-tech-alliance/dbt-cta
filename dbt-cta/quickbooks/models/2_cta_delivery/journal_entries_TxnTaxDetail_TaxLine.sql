select
    _airbyte_TxnTaxDetail_hashid,
    DetailType,
    TaxLineDetail,
    Amount,
    _airbyte_emitted_at,
    _airbyte_TaxLine_hashid
from {{ source('cta','journal_entries_TxnTaxDetail_TaxLine_base') }}