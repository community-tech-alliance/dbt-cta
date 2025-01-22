select
    _airbyte_customers_hashid,
    Address,
    _airbyte_extracted_at,
    _airbyte_PrimaryEmailAddr_hashid
from {{ source('cta','customers_PrimaryEmailAddr_base') }}
