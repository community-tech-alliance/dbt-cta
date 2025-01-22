select
    _airbyte_payments_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_ARAccountRef_hashid
from {{ source('cta','payments_ARAccountRef_base') }}
