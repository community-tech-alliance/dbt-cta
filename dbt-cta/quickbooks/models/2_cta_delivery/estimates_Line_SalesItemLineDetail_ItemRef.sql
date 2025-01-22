select
    _airbyte_SalesItemLineDetail_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_ItemRef_hashid
from {{ source('cta','estimates_Line_SalesItemLineDetail_ItemRef_base') }}
