select
    _airbyte_any_hashid,
    Value,
    Name,
    _airbyte_emitted_at,
    _airbyte_value_hashid
from {{ source('cta','purchases_PurchaseEx_any_value_base') }}