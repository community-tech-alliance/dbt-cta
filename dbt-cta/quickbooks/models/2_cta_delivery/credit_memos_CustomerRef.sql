select
    _airbyte_credit_memos_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_CustomerRef_hashid
from {{ source('cta','credit_memos_CustomerRef_base') }}
