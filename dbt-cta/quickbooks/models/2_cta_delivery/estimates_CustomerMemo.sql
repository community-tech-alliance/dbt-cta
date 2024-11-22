select
    _airbyte_estimates_hashid,
    value,
    _airbyte_emitted_at,
    _airbyte_CustomerMemo_hashid
from {{ source('cta','estimates_CustomerMemo_base') }}
