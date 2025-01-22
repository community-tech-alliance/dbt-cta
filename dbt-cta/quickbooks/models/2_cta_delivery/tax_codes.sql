select
    Description,
    PurchaseTaxRateList,
    airbyte_cursor,
    SalesTaxRateList,
    Name,
    SyncToken,
    Active,
    sparse,
    MetaData,
    TaxGroup,
    domain,
    Hidden,
    Id,
    Taxable,
    _airbyte_extracted_at,
    _airbyte_tax_codes_hashid
from {{ source('cta','tax_codes_base') }}
