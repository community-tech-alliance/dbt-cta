select
    associateOID,
    itemID,
    idValue,
    nameCode_codeValue,
    nameCode_longName,
    countryCode,
    _airbyte_extracted_at,
    _airbyte_government_ids_hashid
from {{ source('cta','government_ids_base') }}
