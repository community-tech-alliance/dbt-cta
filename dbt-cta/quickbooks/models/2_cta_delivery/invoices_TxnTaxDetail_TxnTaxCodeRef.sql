select
    _airbyte_TxnTaxDetail_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_TxnTaxCodeRef_hashid
from {{ source('cta','invoices_TxnTaxDetail_TxnTaxCodeRef_base') }}
