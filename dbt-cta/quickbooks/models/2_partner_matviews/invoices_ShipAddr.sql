select
    _airbyte_invoices_hashid,
    CountrySubDivisionCode,
    Long,
    PostalCode,
    Id,
    City,
    Line1,
    Lat,
    _airbyte_emitted_at,
    _airbyte_ShipAddr_hashid
from {{ source('cta','invoices_ShipAddr_base') }}
