select
    _airbyte_DepositLineDetail_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_AccountRef_hashid
from {{ source('cta','deposits_Line_DepositLineDetail_AccountRef_base') }}
