select
    _airbyte_TxnTaxDetail_hashid,
    DetailType,
    TaxLineDetail,
    Amount,
    _airbyte_extracted_at,
    _airbyte_TaxLine_hashid
from {{ source('cta','invoices_TxnTaxDetail_TaxLine_base') }}
