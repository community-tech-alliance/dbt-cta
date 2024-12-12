select
    _airbyte_credit_memos_hashid,
    Address,
    _airbyte_emitted_at,
    _airbyte_BillEmail_hashid
from {{ source('cta','credit_memos_BillEmail_base') }}
