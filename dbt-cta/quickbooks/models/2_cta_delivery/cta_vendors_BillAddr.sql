select
    _airbyte_vendors_hashid,
    CountrySubDivisionCode,
    Long,
    Country,
    PostalCode,
    Id,
    City,
    Line1,
    Lat,
    _airbyte_emitted_at,
    _airbyte_BillAddr_hashid
from {{ source('cta','vendors_BillAddr_base') }}