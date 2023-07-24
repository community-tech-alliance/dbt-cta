SELECT
    associateOID,
    nameCode_codeValue,
    nameCode_shortName,
    emailUri,
    _airbyte_emitted_at,
    _airbyte_personal_emails_hashid
from {{ source('cta','personal_emails_base') }}