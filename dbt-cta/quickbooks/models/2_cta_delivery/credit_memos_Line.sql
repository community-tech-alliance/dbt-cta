select
    _airbyte_credit_memos_hashid,
    LineNum,
    Description,
    DetailType,
    Amount,
    SalesItemLineDetail,
    Id,
    _airbyte_emitted_at,
    _airbyte_Line_hashid
from {{ source('cta','credit_memos_Line_base') }}
