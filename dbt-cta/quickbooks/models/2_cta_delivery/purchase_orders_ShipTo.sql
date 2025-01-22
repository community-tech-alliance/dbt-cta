select
    _airbyte_purchase_orders_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_ShipTo_hashid
from {{ source('cta','purchase_orders_ShipTo_base') }}
