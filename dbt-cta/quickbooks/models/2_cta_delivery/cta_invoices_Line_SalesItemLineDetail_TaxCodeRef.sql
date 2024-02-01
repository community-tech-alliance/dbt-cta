select
    _airbyte_SalesItemLineDetail_hashid,
    value,
    _airbyte_emitted_at,
    _airbyte_TaxCodeRef_hashid
from {{ source('cta','invoices_Line_SalesItemLineDetail_TaxCodeRef_base') }}