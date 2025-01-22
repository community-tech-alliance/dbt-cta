select
    _airbyte_bill_payments_hashid,
    Amount,
    LinkedTxn,
    _airbyte_extracted_at,
    _airbyte_Line_hashid
from {{ source('cta','bill_payments_Line_base') }}
