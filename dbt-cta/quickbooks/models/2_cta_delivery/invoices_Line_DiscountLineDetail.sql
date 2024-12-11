select
    _airbyte_Line_hashid,
    PercentBased,
    DiscountAccountRef,
    DiscountPercent,
    _airbyte_emitted_at,
    _airbyte_DiscountLineDetail_hashid
from {{ source('cta','invoices_Line_DiscountLineDetail_base') }}
