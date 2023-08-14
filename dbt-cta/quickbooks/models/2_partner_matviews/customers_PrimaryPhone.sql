select
    _airbyte_customers_hashid,
    FreeFormNumber,
    _airbyte_emitted_at,
    _airbyte_PrimaryPhone_hashid
from {{ source('cta','customers_PrimaryPhone_base') }}