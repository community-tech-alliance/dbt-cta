{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('job_request_ab4') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_job_request_hashid
from {{ ref('job_request_ab4') }}
-- job_request from {{ source('cta', '_airbyte_raw_job_request') }}
where 1=1

