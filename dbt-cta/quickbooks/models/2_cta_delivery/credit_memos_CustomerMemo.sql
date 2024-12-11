select
    _airbyte_credit_memos_hashid,
    value,
    _airbyte_emitted_at,
    _airbyte_CustomerMemo_hashid
from {{ source('cta','credit_memos_CustomerMemo_base') }}
