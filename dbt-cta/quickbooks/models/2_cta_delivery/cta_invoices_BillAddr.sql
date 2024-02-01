select
    _airbyte_invoices_hashid,
    Line4,
    CountrySubDivisionCode,
    Long,
    PostalCode,
    Id,
    City,
    Line1,
    Lat,
    Line2,
    Line3,
    _airbyte_emitted_at,
    _airbyte_BillAddr_hashid
from {{ source('cta','invoices_BillAddr_base') }}