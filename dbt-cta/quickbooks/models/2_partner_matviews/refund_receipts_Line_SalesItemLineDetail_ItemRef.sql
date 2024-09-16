select
    _airbyte_SalesItemLineDetail_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_ItemRef_hashid
from {{ source('cta','refund_receipts_Line_SalesItemLineDetail_ItemRef_base') }}
