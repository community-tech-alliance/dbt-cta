select
    _airbyte_Line_hashid,
    TaxCodeRef,
    BillableStatus,
    AccountRef,
    CustomerRef,
    _airbyte_extracted_at,
    _airbyte_AccountBasedExpenseLineDetail_hashid
from {{ source('cta','purchases_Line_AccountBasedExpenseLineDetail_base') }}
