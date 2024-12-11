select
    _airbyte_DiscountLineDetail_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_DiscountAccountRef_hashid
from {{ source('cta','sales_receipts_Line_DiscountLineDetail_DiscountAccountRef_base') }}
