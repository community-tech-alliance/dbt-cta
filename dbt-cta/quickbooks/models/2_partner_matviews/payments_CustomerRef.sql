select
    _airbyte_payments_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CustomerRef_hashid
from {{ source('cta','payments_CustomerRef_base') }}