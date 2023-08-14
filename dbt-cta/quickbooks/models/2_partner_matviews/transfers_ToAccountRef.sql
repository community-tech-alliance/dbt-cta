select
    _airbyte_transfers_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_ToAccountRef_hashid
from {{ source('cta','transfers_ToAccountRef_base') }}