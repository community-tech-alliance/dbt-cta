select
    _airbyte_emitted_at,
    sid,
    uri,
    max_size,
    account_sid,
    current_size,
    date_created,
    date_updated,
    friendly_name,
    subresource_uris,
    average_wait_time,
from {{ source('cta','queues_base') }}