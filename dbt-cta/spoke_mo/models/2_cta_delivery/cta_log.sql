select
    from_num,
    to_num,
    created_at,
    error_code,
    id,
    body,
    message_sid,
    _airbyte_extracted_at,
    _airbyte_log_hashid
from {{ source('cta','log_base') }}