select
    _airbyte_items_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_AssetAccountRef_hashid
from {{ source('cta','items_AssetAccountRef_base') }}