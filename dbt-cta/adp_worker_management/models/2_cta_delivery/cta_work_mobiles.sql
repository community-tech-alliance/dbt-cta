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
    _airbyte_work_mobiles_hashid
from {{ source('cta','work_mobiles_base') }}
