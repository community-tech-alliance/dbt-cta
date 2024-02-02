select
    _airbyte_estimates_hashid,
    Type,
    DefinitionId,
    Name,
    _airbyte_emitted_at,
    _airbyte_CustomField_hashid
from {{ source('cta','estimates_CustomField_base') }}