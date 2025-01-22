select
    _airbyte_estimates_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_CustomerMemo_hashid
from {{ source('cta','estimates_CustomerMemo_base') }}
