select
    _airbyte_refund_receipts_hashid,
    TotalTax,
    _airbyte_extracted_at,
    _airbyte_TxnTaxDetail_hashid
from {{ source('cta','refund_receipts_TxnTaxDetail_base') }}
