select
    _airbyte_customers_hashid,
    FreeFormNumber,
    _airbyte_emitted_at,
    _airbyte_Mobile_hashid
from {{ source('cta','customers_Mobile_base') }}
