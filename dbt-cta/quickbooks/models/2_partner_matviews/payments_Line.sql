select
    _airbyte_payments_hashid,
    Amount,
    LineEx,
    LinkedTxn,
    _airbyte_emitted_at,
    _airbyte_Line_hashid
from {{ source('cta','payments_Line_base') }}