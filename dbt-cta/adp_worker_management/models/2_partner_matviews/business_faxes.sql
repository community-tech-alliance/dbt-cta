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
    _airbyte_business_faxes_hashid
from {{ source('cta','business_faxes_base') }}