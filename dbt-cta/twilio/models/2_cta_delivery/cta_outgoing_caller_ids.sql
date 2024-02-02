select
    _airbyte_emitted_at,
    sid,
    uri,
    account_sid,
    date_created,
    date_updated,
    phone_number,
    friendly_name
from {{ source('cta','outgoing_caller_ids_base') }}
