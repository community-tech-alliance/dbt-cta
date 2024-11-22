select
    _airbyte_TxnTaxDetail_hashid,
    value,
    _airbyte_emitted_at,
    _airbyte_TxnTaxCodeRef_hashid
from {{ source('cta','estimates_TxnTaxDetail_TxnTaxCodeRef_base') }}
