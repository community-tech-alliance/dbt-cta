select
    _airbyte_estimates_hashid,
    LineNum,
    Description,
    DetailType,
    Amount,
    SalesItemLineDetail,
    Id,
    _airbyte_extracted_at,
    _airbyte_Line_hashid
from {{ source('cta','estimates_Line_base') }}
