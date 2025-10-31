{{
    config(
        materialized='ephemeral',
        tags = [
            'airbyte-usage'
        ]
    )
}}

select
    -- pk
    jobId as job_id,
    -- ids
    connectionId as connection_id,
    -- attributes
    coalesce(
        safe.timestamp(startTime),
        safe.parse_timestamp('%Y-%m-%dT%H:%M%Ez', startTime)
    ) as job_started_at,
    -- facts
    rowsSynced as rows_synced,
    bytesSynced as bytes_synced
from {{ source('airbyte_usage', 'jobs') }}
where status in ( -- for now, we'll only consider completed jobs
    'succeeded',
    'failed'
)
