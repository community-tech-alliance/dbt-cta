select
    _airbyte_LineEx_hashid,
    nil,
    typeSubstituted,
    globalScope,
    scope,
    name,
    declaredType,
    value,
    _airbyte_emitted_at,
    _airbyte_any_hashid
from {{ source('cta','payments_Line_LineEx_any_base') }}
