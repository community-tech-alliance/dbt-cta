select
    _airbyte_TaxLineDetail_hashid,
    value,
    _airbyte_emitted_at,
    _airbyte_TaxRateRef_hashid
from {{ source('cta','estimates_TxnTaxDetail_TaxLine_TaxLineDetail_TaxRateRef_base') }}
