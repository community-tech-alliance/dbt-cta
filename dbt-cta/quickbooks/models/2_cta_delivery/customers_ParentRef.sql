select
    _airbyte_customers_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_ParentRef_hashid
from {{ source('cta','customers_ParentRef_base') }}
