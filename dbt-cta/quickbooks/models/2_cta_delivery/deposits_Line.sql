select
    _airbyte_deposits_hashid,
    LineNum,
    DepositLineDetail,
    DetailType,
    Amount,
    Id,
    LinkedTxn,
    _airbyte_extracted_at,
    _airbyte_Line_hashid
from {{ source('cta','deposits_Line_base') }}
