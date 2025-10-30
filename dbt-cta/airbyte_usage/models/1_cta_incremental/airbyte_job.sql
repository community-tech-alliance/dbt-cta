{{
    config(
        materialized = 'incremental',
        unique_key = 'job_id',
        tags = [
            'airbyte-usage'
        ]
    )
}}

with connection_source as (
    select
        connections.connection_id,
        sources.billing_type
    from {{ ref('connection') }} as connections
    inner join {{ ref('source') }} as sources
        on connections.source_id = sources.source_id
)

select
    jobs.job_id,
    jobs.connection_id,
    jobs.job_started_at,
    jobs.rows_synced,
    jobs.bytes_synced,
    case connections.billing_type
        when "records" then safe_divide(jobs.rows_synced, (power(10, 6) / 6))  -- 6 credits per million records
        when "bytes" then safe_divide(jobs.bytes_synced, (power(2, 30) / 4))  -- 4 credits per GiB
    end as credits_billed
from {{ ref('job') }} as jobs
inner join connection_source as connections
    on jobs.connection_id = connections.connection_id
{% if is_incremental() %}
where jobs.job_started_at > (
    select max(job_started_at) from {{ this }}
)
{% endif %}
