select
    _airbyte_estimates_hashid,
    TotalTax,
    TxnTaxCodeRef,
    TaxLine,
    _airbyte_emitted_at,
    _airbyte_TxnTaxDetail_hashid
from {{ source('cta','estimates_TxnTaxDetail_base') }}