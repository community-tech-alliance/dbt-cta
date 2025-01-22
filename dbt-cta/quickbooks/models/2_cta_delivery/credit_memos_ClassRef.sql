select
    _airbyte_credit_memos_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_ClassRef_hashid
from {{ source('cta','credit_memos_ClassRef_base') }}
