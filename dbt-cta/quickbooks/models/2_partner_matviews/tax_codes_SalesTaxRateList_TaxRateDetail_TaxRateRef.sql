select
    _airbyte_TaxRateDetail_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_TaxRateRef_hashid
from {{ source('cta','tax_codes_SalesTaxRateList_TaxRateDetail_TaxRateRef_base') }}