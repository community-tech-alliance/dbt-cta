select
    _airbyte_SalesTaxRateList_hashid,
    TaxOrder,
    TaxRateRef,
    TaxTypeApplicable,
    _airbyte_extracted_at,
    _airbyte_TaxRateDetail_hashid
from {{ source('cta','tax_codes_SalesTaxRateList_TaxRateDetail_base') }}
