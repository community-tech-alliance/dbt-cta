select
    _airbyte_customers_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_DefaultTaxCodeRef_hashid
from {{ source('cta','customers_DefaultTaxCodeRef_base') }}
