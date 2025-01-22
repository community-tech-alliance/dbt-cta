select
    _airbyte_TaxLineDetail_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_TaxRateRef_hashid
from {{ source('cta','invoices_TxnTaxDetail_TaxLine_TaxLineDetail_TaxRateRef_base') }}
