select
    _airbyte_sales_receipts_hashid,
    value,
    _airbyte_emitted_at,
    _airbyte_CustomerMemo_hashid
from {{ source('cta','sales_receipts_CustomerMemo_base') }}
