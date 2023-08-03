-- this model creates a view that can be unioned into the existing reporting view, which was originally designed to report on DAG syncs
with
    source as (select * from {{ ref("int_workflow_logs") }} ),
    add_most_recent_run as (
        select
            *,
            case
                when
                    rank() over (
                        partition by
                            workflow_id, sync, partner_name, extract(date from execution_start_time)
                        order by log_timestamp desc
                    )
                    = 1
                then 1
                else 0
            end as most_recent_run_per_day,
        from source
    )

select
    "Workflows" as sync_type,
    project_id,
    cast(null as string) as dag_id,
    workflow_id as workflow_id,
    coalesce(sync,'NA') as sync_name,
    coalesce(partner_name,'NA') as partner_name,
    cast(null as string) as run_id,
    execution_id as workflow_execution_id,
    {{ dbt_date.convert_timezone("execution_start_time", 'America/New_York', 'UTC') }} as run_started_at,
    {{ dbt_date.convert_timezone("execution_finish_time", 'America/New_York', 'UTC') }} as run_completed_at,
    {{ dbt_date.convert_timezone("log_timestamp", 'America/New_York', 'UTC') }} as workflow_log_timestamp,
    state as status,
    most_recent_run_per_day,
    runtime_minutes as runtime,
    case when most_recent_run_per_day=1 then failure_flag else 0 end as total_errors,
    null as num_steps,
    null as num_steps_run,
    null as test_errors,
    null as successful_tests,
    null as total_tests,
    null as model_errors,
    null as successful_models,
    null as total_models,
    failure_exception as error_message
from add_most_recent_run