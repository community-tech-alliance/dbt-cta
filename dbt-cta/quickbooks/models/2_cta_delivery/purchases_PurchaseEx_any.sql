select
    _airbyte_PurchaseEx_hashid,
    nil,
    typeSubstituted,
    globalScope,
    scope,
    name,
    declaredType,
    value,
    _airbyte_emitted_at,
    _airbyte_any_hashid
from {{ source('cta','purchases_PurchaseEx_any_base') }}
