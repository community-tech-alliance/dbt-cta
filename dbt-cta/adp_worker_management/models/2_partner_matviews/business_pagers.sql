SELECT
    associateOID,
    itemID,
    nameCode_codeValue,
    nameCode_shortName,
    countryDialing,
    areaDialing,
    dialNumber,
    access,
    formattedNumber,
    _airbyte_emitted_at,
    _airbyte_business_pagers_hashid
from {{ source('cta','business_pagers_base') }}