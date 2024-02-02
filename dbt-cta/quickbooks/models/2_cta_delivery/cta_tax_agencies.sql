select
    SyncToken,
    TaxTrackedOnPurchases,
    sparse,
    TaxRegistrationNumber,
    MetaData,
    domain,
    airbyte_cursor,
    DisplayName,
    Id,
    TaxTrackedOnSales,
    _airbyte_emitted_at,
    _airbyte_tax_agencies_hashid
from {{ source('cta','tax_agencies_base') }}