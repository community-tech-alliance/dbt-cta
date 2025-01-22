select
    _airbyte_purchase_orders_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_ClassRef_hashid
from {{ source('cta','purchase_orders_ClassRef_base') }}
