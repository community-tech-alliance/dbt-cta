select
    _airbyte_credit_memos_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_SalesTermRef_hashid
from {{ source('cta','credit_memos_SalesTermRef_base') }}