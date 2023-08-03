with
    unioned_logs as (select * from {{ ref("int_merge_logs") }}),
    elementary_logs as (select * from {{ ref("int_group_by_run") }}),
    workflow_reporting_view as (select * from {{ ref("int_workflow_logs_reporting") }}),
    join_elementary_model_info as (
        select ul.*
        , el.test_errors
        , el.model_errors
        , el.total_models
        , el.total_tests
        , el.num_steps
        , el.num_steps_run
        
        from unioned_logs ul
        left join elementary_logs el on ul.run_id = el.airflow_run_id and ul.sync_name = el.sync_name and ul.partner_name = el.partner_name
    ),
    compute_successes as (
        select
            *,
            case
                when coalesce(test_errors, 0) + coalesce(model_errors, 0) > 0
                then false
                else true
            end as elementary_success,
            total_models - model_errors as successful_models,
            total_tests - test_errors as successful_tests,
        from join_elementary_model_info
    ),
    coalesce_status as (
        select * except(run_status,elementary_success)
        -- Prefer Composer status, but flag failures if there are any from Elementary
        , case when elementary_success = false then 'failed' else run_status end as status
        from compute_successes
    ),
    add_total_errors as (
        select *
        -- For elementray failures, use the number of errors from the Elementary logs,
        -- otherwise just use '1' for the number of errors if the run failed
        , case
            when status = 'failed' then greatest(1, coalesce(model_errors,0) + coalesce(test_errors,0))
            else coalesce(model_errors+test_errors,0) end as total_errors
        from coalesce_status
    ),
    add_most_recent_run as (
        select
            *,
            case
                when
                    rank() over (
                        partition by
                            sync_name, partner_name, extract(date from run_started_at)
                        order by run_started_at desc
                    )
                    = 1
                then 1
                else 0
            end as most_recent_run_per_day,
        from add_total_errors
    ),
    add_run_time as (
        select *, datetime_diff(run_finished_at, run_started_at, minute) as runtime
        from add_most_recent_run
    ),
    composer_reporting_view as (
        select
            "Composer" as sync_type,
            project_id,
            dag_id,
            cast(null as string) as workflow_id,
            coalesce(sync_name,'NA') as sync_name,
            coalesce(partner_name,'NA') as partner_name,
            run_id,
            cast(null as string) as workflow_execution_id,
            run_started_at,
            run_finished_at as run_completed_at,
            cast(null as timestamp) as workflow_log_timestamp,
            status,
            most_recent_run_per_day,
            runtime,
            total_errors,
            num_steps,
            num_steps_run,
            test_errors,
            successful_tests,
            total_tests,
            model_errors,
            successful_models,
            total_models,
            error_message

        from add_run_time
    )

select *
from composer_reporting_view

UNION ALL

select *
from workflow_reporting_view