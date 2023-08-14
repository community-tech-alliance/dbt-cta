select
    _airbyte_estimates_hashid,
    CountrySubDivisionCode,
    Long,
    PostalCode,
    Id,
    City,
    Line1,
    Lat,
    _airbyte_emitted_at,
    _airbyte_ShipAddr_hashid
from {{ source('cta','estimates_ShipAddr_base') }}