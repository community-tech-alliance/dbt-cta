select
    _airbyte_purchase_orders_hashid,
    Line4,
    Long,
    Country,
    Id,
    City,
    Line1,
    Lat,
    Line2,
    Line3,
    _airbyte_emitted_at,
    _airbyte_VendorAddr_hashid
from {{ source('cta','purchase_orders_VendorAddr_base') }}
