select
    _airbyte_purchase_orders_hashid,
    Type,
    DefinitionId,
    Name,
    _airbyte_extracted_at,
    _airbyte_CustomField_hashid
from {{ source('cta','purchase_orders_CustomField_base') }}
