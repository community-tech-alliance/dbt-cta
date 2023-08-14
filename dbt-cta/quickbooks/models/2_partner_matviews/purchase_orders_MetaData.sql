select
    _airbyte_purchase_orders_hashid,
    CreateTime,
    LastUpdatedTime,
    _airbyte_emitted_at,
    _airbyte_MetaData_hashid
from {{ source('cta','purchase_orders_MetaData_base') }}