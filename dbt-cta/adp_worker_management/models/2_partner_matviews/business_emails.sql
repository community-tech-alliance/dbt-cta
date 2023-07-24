SELECT
    associateOID,
    nameCode_codeValue,
    nameCode_shortName,
    emailUri,
    _airbyte_emitted_at,
    _airbyte_business_emails_hashid
from {{ source('cta','business_emails_base') }}