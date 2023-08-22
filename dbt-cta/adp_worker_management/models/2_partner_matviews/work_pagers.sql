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
    _airbyte_emitted_at,
    _airbyte_work_pagers_hashid
from {{ source('cta','work_pagers_base') }}
