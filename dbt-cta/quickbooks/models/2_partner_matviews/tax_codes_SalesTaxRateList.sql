select
    _airbyte_tax_codes_hashid,
    TaxRateDetail,
    _airbyte_emitted_at,
    _airbyte_SalesTaxRateList_hashid
from {{ source('cta','tax_codes_SalesTaxRateList_base') }}