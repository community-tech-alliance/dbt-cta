{{ config(
    unique_key = 'sid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('alerts_ab3') }}
select
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
from {{ ref('alerts_ab3') }}

