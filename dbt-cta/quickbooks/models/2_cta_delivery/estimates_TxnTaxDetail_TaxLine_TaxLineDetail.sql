select
    _airbyte_TaxLine_hashid,
    PercentBased,
    TaxRateRef,
    NetAmountTaxable,
    TaxPercent,
    _airbyte_extracted_at,
    _airbyte_TaxLineDetail_hashid
from {{ source('cta','estimates_TxnTaxDetail_TaxLine_TaxLineDetail_base') }}
