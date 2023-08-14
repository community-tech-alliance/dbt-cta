select
    _airbyte_SalesItemLineDetail_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_ClassRef_hashid
from {{ source('cta','invoices_Line_SalesItemLineDetail_ClassRef_base') }}