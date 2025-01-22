select
    _airbyte_estimates_hashid,
    TotalTax,
    TxnTaxCodeRef,
    TaxLine,
    _airbyte_extracted_at,
    _airbyte_TxnTaxDetail_hashid
from {{ source('cta','estimates_TxnTaxDetail_base') }}
