SELECT
    associateOID,
    itemID,
    nameCode_codeValue,
    nameCode_shortName,
    typeCode_codeValue,
    typeCode_shortName,
    _airbyte_emitted_at,
    _airbyte_work_assignments_home_organizational_units_hashid
from {{ source('cta','work_assignments_home_organizational_units_base') }}