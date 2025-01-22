select
    _airbyte_any_hashid,
    Value,
    Name,
    _airbyte_extracted_at,
    _airbyte_value_hashid
from {{ source('cta','payments_Line_LineEx_any_value_base') }}
