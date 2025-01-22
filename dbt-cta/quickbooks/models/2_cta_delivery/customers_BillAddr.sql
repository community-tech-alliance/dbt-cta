select
    _airbyte_customers_hashid,
    CountrySubDivisionCode,
    Long,
    Country,
    PostalCode,
    Id,
    City,
    Line1,
    Lat,
    _airbyte_extracted_at,
    _airbyte_BillAddr_hashid
from {{ source('cta','customers_BillAddr_base') }}
