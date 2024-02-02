select
    _airbyte_invoices_hashid,
    value,
    _airbyte_emitted_at,
    _airbyte_CustomerMemo_hashid
from {{ source('cta','invoices_CustomerMemo_base') }}