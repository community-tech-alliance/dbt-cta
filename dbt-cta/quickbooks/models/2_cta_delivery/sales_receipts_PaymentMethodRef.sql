select
    _airbyte_sales_receipts_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_PaymentMethodRef_hashid
from {{ source('cta','sales_receipts_PaymentMethodRef_base') }}
