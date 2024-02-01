select
    _airbyte_DiscountLineDetail_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_DiscountAccountRef_hashid
from {{ source('cta','invoices_Line_DiscountLineDetail_DiscountAccountRef_base') }}