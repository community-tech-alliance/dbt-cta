select
    _airbyte_sales_receipts_hashid,
    Type,
    DefinitionId,
    Name,
    _airbyte_emitted_at,
    _airbyte_CustomField_hashid
from {{ source('cta','sales_receipts_CustomField_base') }}