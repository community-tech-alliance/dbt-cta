select
    _airbyte_credit_memos_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','credit_memos_MetaData_base') }}
