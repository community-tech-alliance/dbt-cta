select
    _airbyte_invoices_hashid,
    Type,
    DefinitionId,
    StringValue,
    Name,
    _airbyte_extracted_at,
    _airbyte_CustomField_hashid
from {{ source('cta','invoices_CustomField_base') }}
