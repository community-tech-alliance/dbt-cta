select
    _airbyte_sales_receipts_hashid,
    TotalTax,
    _airbyte_emitted_at,
    _airbyte_TxnTaxDetail_hashid
from {{ source('cta','sales_receipts_TxnTaxDetail_base') }}