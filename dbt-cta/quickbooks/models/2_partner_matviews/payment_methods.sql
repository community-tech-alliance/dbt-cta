select
    SyncToken,
    Type,
    Active,
    sparse,
    MetaData,
    domain,
    airbyte_cursor,
    Id,
    Name,
    _airbyte_emitted_at,
    _airbyte_payment_methods_hashid
from {{ source('cta','payment_methods_base') }}