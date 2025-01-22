select
    _airbyte_customers_hashid,
    URI,
    _airbyte_extracted_at,
    _airbyte_WebAddr_hashid
from {{ source('cta','customers_WebAddr_base') }}
