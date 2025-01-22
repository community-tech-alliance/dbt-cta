select
    _airbyte_sales_receipts_hashid,
    CountrySubDivisionCode,
    Long,
    Country,
    PostalCode,
    Id,
    City,
    Line1,
    Lat,
    _airbyte_extracted_at,
    _airbyte_ShipAddr_hashid
from {{ source('cta','sales_receipts_ShipAddr_base') }}
