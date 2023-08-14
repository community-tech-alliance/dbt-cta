select
    _airbyte_Line_hashid,
    {{ adapter.quote('any') }},
    _airbyte_emitted_at,
    _airbyte_LineEx_hashid
from {{ source('cta','payments_Line_LineEx_base') }}