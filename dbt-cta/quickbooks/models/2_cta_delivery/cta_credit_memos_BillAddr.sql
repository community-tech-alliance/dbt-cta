select
    _airbyte_credit_memos_hashid,
    Line4,
    Long,
    Id,
    Line1,
    Lat,
    Line2,
    Line3,
    _airbyte_emitted_at,
    _airbyte_BillAddr_hashid
from {{ source('cta','credit_memos_BillAddr_base') }}