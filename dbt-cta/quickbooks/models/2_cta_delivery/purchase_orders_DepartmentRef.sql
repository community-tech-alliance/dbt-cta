select
    _airbyte_purchase_orders_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_DepartmentRef_hashid
from {{ source('cta','purchase_orders_DepartmentRef_base') }}
