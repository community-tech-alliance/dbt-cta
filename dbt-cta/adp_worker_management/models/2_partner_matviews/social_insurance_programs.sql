SELECT
    associateOID,
    nameCode_codeValue,
    nameCode_shortName,
    coveredIndicator,
    _airbyte_emitted_at,
    _airbyte_social_insurance_programs_hashid
from {{ source('cta','social_insurance_programs_base') }}