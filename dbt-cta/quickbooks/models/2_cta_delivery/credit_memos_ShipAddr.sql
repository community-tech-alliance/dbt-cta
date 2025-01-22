select
    _airbyte_credit_memos_hashid,
    CountrySubDivisionCode,
    Long,
    PostalCode,
    Id,
    City,
    Line1,
    Lat,
    _airbyte_extracted_at,
    _airbyte_ShipAddr_hashid
from {{ source('cta','credit_memos_ShipAddr_base') }}
