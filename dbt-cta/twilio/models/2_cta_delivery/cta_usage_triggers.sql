select
    _airbyte_emitted_at,
    sid,
    uri,
    recurring,
    date_fired,
    trigger_by,
    account_sid,
    api_version,
    callback_url,
    date_created,
    date_updated,
    current_value,
    friendly_name,
    trigger_value,
    usage_category,
    callback_method,
    usage_record_uri
from {{ source('cta','usage_triggers_base') }}
