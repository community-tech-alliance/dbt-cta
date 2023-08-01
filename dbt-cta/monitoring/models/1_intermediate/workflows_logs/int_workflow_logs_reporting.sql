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
                        order by execution_start_time desc
                    )
                    = 1
                then 1
                else 0
            end as most_recent_run_per_day,
        from source
    )

select
    "Workflows" as sync_type,
    cast(null as string) as dag_id,
    workflow_id as workflow_id,
    coalesce(sync,'NA') as sync_name,
    coalesce(partner_name,'NA') as partner_name,
    cast(null as string) as run_id,
    execution_id as workflow_execution_id,
    execution_start_time as run_started_at,
    execution_finish_time as run_completed_at,
    state as status,
    case when exec_order=1 then 1 else 0 end as most_recent_run_per_day,
    runtime_minutes as runtime,
    failure_flag as total_errors,
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