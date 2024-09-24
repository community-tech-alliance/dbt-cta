select
    AgencyRef,
    RateValue,
    Description,
    DisplayType,
    airbyte_cursor,
    Name,
    SpecialTaxType,
    SyncToken,
    EffectiveTaxRate,
    Active,
    sparse,
    MetaData,
    domain,
    Id,
    _airbyte_emitted_at,
    _airbyte_tax_rates_hashid
from {{ source('cta','tax_rates_base') }}
