select
    _airbyte_accounts_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_ParentRef_hashid
from {{ source('cta','accounts_ParentRef_base') }}
