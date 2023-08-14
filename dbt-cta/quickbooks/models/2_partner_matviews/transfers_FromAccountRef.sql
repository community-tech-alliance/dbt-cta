select
    _airbyte_transfers_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_FromAccountRef_hashid
from {{ source('cta','transfers_FromAccountRef_base') }}