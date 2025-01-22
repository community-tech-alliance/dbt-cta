select
    _airbyte_SalesItemLineDetail_hashid,
    value,
    _airbyte_extracted_at,
    _airbyte_TaxCodeRef_hashid
from {{ source('cta','credit_memos_Line_SalesItemLineDetail_TaxCodeRef_base') }}
