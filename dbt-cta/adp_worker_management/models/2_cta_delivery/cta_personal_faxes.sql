select
    associateOID,
    itemID,
    nameCode_codeValue,
    nameCode_shortName,
    countryDialing,
    areaDialing,
    dialNumber,
    access,
    formattedNumber,
    _airbyte_extracted_at,
    _airbyte_personal_faxes_hashid
from {{ source('cta','personal_faxes_base') }}
