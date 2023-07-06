select
    job_type,
    queue_name,
    updated_at,
    result_message,
    payload,
    organization_id,
    created_at,
    assigned,
    locks_queue,
    id,
    campaign_id,
    status,
    _airbyte_emitted_at,
    _airbyte_job_request_hashid
from {{ source('cta','job_request_base') }}