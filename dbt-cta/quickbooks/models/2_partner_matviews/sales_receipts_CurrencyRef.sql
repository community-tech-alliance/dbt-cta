select
    _airbyte_sales_receipts_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','sales_receipts_CurrencyRef_base') }}