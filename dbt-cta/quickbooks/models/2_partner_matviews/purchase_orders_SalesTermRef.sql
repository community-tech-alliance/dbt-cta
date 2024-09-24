select
    _airbyte_purchase_orders_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_SalesTermRef_hashid
from {{ source('cta','purchase_orders_SalesTermRef_base') }}
