
with
    source as (select * from {{ ref("stg_workflows_execution_logs") }}),
    workflow_metadata as (select * from {{ ref("stg_meta__workflow_mapping") }}),
    /*
    -- FOR TESTING
    source as (
        select
            *
        from `dev3869c056.monitoring.stg_workflows_execution_logs`
        where workflow_id='sm-run-redshift-syncs'
    ),
    */
    add_exec_order as (
        select
            *,
            row_number() over (
                partition by execution_id order by log_timestamp desc
            ) as exec_order,
            min(log_timestamp) over (
                partition by execution_id
            ) as execution_start_time,
            max(log_timestamp) over (
                partition by execution_id
            ) as execution_finish_time,
        from source
    ),
    latest_only as (
        select
            workflow_id,
            execution_id,
            log_timestamp,
            state
        from add_exec_order
        where exec_order=1
    ),
    complete_source_data as (
        select
            a.log_timestamp,
            a.project_id,
            a.partner_name,
            a.workflow_id,
            a.execution_id,
            a.exec_order,
            a.state,
            CASE WHEN a.state='FAILED' then 1 else 0 end as failure_flag, --include this in the final reporting view, which sums across error counts
            a.arguments,
            a.failure_source,
            a.failure_exception,
            a.execution_start_time,
            CASE WHEN latest.state in ('FAILED','SUCCEEDED') then a.execution_finish_time ELSE null END as execution_finish_time,
            datetime_diff(a.execution_finish_time, a.execution_start_time, minute) as runtime_minutes
        from add_exec_order as a
        left join latest_only as latest using(execution_id)
    )

select
    source.log_timestamp,
    source.project_id,
    source.workflow_id,
    source.execution_id,
    source.exec_order,
    source.state,
    source.failure_flag,
    source.arguments,
    source.failure_source,
    source.failure_exception,
    source.execution_start_time,
    source.execution_finish_time,
    source.runtime_minutes,
    meta.sync,
    COALESCE(source.partner_name,meta.partner_name) as partner_name,
    meta.data_type
from complete_source_data as source
left join workflow_metadata as meta using(workflow_id)