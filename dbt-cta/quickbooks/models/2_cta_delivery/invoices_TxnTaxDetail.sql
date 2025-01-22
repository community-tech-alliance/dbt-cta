select
    _airbyte_invoices_hashid,
    TotalTax,
    TxnTaxCodeRef,
    TaxLine,
    _airbyte_extracted_at,
    _airbyte_TxnTaxDetail_hashid
from {{ source('cta','invoices_TxnTaxDetail_base') }}
