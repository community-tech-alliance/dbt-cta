select
    _airbyte_credit_memos_hashid,
    TotalTax,
    _airbyte_extracted_at,
    _airbyte_TxnTaxDetail_hashid
from {{ source('cta','credit_memos_TxnTaxDetail_base') }}
