select
    _airbyte_emitted_at,
    sid,
    url,
    log_level,
    more_info,
    alert_text,
    error_code,
    account_sid,
    api_version,
    request_url,
    service_sid,
    date_created,
    date_updated,
    resource_sid,
    date_generated,
    request_method
from {{ source('cta','alerts_base') }}
