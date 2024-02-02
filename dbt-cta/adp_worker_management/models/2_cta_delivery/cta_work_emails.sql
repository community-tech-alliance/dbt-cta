select
    associateOID,
    nameCode_codeValue,
    nameCode_shortName,
    emailUri,
    _airbyte_emitted_at,
    _airbyte_work_emails_hashid
from {{ source('cta','work_emails_base') }}
