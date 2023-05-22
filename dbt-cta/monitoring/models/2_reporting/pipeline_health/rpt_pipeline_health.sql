with
    unioned_logs as (select * from {{ ref("int_merge_logs") }}),
    elementary_logs as (select * from {{ ref("int_group_by_run") }}),

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
        from coalesce_status
    ),
    add_run_time as (
        select *, datetime_diff(run_finished_at, run_started_at, minute) as runtime
        from add_most_recent_run
    ),
    final as (
        select
            dag_id,
            sync_name,
            partner_name,
            run_id,
            num_steps,
            num_steps_run,
            run_started_at,
            run_finished_at as run_completed_at,
            status,
            most_recent_run_per_day,
            runtime,
            test_errors,
            successful_tests,
            total_tests,
            model_errors,
            successful_models,
            total_models,

        from add_run_time
    )

select *
from final
