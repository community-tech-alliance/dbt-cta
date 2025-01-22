select
    _airbyte_purchases_hashid,
    CountrySubDivisionCode,
    Long,
    PostalCode,
    Id,
    City,
    Line1,
    Lat,
    _airbyte_extracted_at,
    _airbyte_RemitToAddr_hashid
from {{ source('cta','purchases_RemitToAddr_base') }}
