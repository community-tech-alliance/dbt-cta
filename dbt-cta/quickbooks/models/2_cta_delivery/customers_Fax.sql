select
    _airbyte_customers_hashid,
    FreeFormNumber,
    _airbyte_extracted_at,
    _airbyte_Fax_hashid
from {{ source('cta','customers_Fax_base') }}
