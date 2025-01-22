select
    _airbyte_bill_payments_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_DepartmentRef_hashid
from {{ source('cta','bill_payments_DepartmentRef_base') }}
