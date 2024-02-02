select
    _airbyte_purchases_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_AccountRef_hashid
from {{ source('cta','purchases_AccountRef_base') }}