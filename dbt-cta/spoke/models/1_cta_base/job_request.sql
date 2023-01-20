{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('job_request_ab3') }}
select
    id,
    status,
    payload,
    assigned,
    job_type,
    created_at,
    queue_name,
    updated_at,
    campaign_id,
    locks_queue,
    result_message,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_job_request_hashid
from {{ ref('job_request_ab3') }}
-- job_request from {{ source('public', '_airbyte_raw_job_request') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

