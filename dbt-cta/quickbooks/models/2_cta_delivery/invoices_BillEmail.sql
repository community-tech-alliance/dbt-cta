select
    _airbyte_invoices_hashid,
    Address,
    _airbyte_emitted_at,
    _airbyte_BillEmail_hashid
from {{ source('cta','invoices_BillEmail_base') }}
