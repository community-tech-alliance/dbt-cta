select
    _airbyte_refund_receipts_hashid,
    Type,
    DefinitionId,
    Name,
    _airbyte_emitted_at,
    _airbyte_CustomField_hashid
from {{ source('cta','refund_receipts_CustomField_base') }}