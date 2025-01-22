select
    _airbyte_TaxLine_hashid,
    PercentBased,
    TaxRateRef,
    TaxInclusiveAmount,
    OverrideDeltaAmount,
    NetAmountTaxable,
    TaxPercent,
    _airbyte_extracted_at,
    _airbyte_TaxLineDetail_hashid
from {{ source('cta','journal_entries_TxnTaxDetail_TaxLine_TaxLineDetail_base') }}
