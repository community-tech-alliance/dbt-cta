select
    _airbyte_vendors_hashid,
    Address,
    _airbyte_emitted_at,
    _airbyte_PrimaryEmailAddr_hashid
from {{ source('cta','vendors_PrimaryEmailAddr_base') }}