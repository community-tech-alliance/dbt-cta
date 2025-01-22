select
    _airbyte_credit_memos_hashid,
    Type,
    DefinitionId,
    Name,
    _airbyte_extracted_at,
    _airbyte_CustomField_hashid
from {{ source('cta','credit_memos_CustomField_base') }}
