select
    _airbyte_purchase_orders_hashid,
    Long,
    Id,
    Line1,
    Lat,
    Line2,
    Line3,
    _airbyte_emitted_at,
    _airbyte_ShipAddr_hashid
from {{ source('cta','purchase_orders_ShipAddr_base') }}