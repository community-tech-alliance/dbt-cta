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
    _airbyte_work_landlines_hashid
from {{ source('cta','work_landlines_base') }}
