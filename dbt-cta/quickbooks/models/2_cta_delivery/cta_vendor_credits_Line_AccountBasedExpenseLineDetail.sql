select
    _airbyte_Line_hashid,
    ClassRef,
    TaxCodeRef,
    BillableStatus,
    AccountRef,
    CustomerRef,
    _airbyte_emitted_at,
    _airbyte_AccountBasedExpenseLineDetail_hashid
from {{ source('cta','vendor_credits_Line_AccountBasedExpenseLineDetail_base') }}
