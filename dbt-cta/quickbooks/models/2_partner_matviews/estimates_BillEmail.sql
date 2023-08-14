select
    _airbyte_estimates_hashid,
    Address,
    _airbyte_emitted_at,
    _airbyte_BillEmail_hashid
from {{ source('cta','estimates_BillEmail_base') }}