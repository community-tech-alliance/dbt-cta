select
    _airbyte_tax_rates_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_AgencyRef_hashid
from {{ source('cta','tax_rates_AgencyRef_base') }}
