with
    source as (select * from {{ ref("int_group_by_run") }}),
    compute_successes as (

        select
            *,
            case
                when coalesce(test_errors, 0) + coalesce(model_errors, 0) > 0
                then false
                else true
            end as success,
            case
                when coalesce(test_errors, 0) + coalesce(model_errors, 0) > 0
                then 0
                else 1
            end as success_int,
            total_models - model_errors as successful_models,
            total_tests - test_errors as successful_tests,
        from source
    ),
    add_most_recent_run as (
        select
            *,
            case when rank() over (
                partition by sync_name, partner_name, extract(date from run_started_at)
                order by run_started_at desc
            ) = 1 then 1 else 0 end as most_recent_run_per_day,
        from compute_successes
    ),
    add_run_time as (
        select *, datetime_diff(run_completed_at, run_started_at, minute) as runtime
        from add_most_recent_run
    ),
    final as (select 
    sync_name
    , partner_name
    , airflow_run_id
    , num_steps
    , run_started_at
    , run_completed_at
    , test_errors
    , successful_tests
    , total_tests
    , model_errors
    , successful_models
    , total_models
    , success
    , success_int
    , most_recent_run_per_day
    , runtime
     from add_run_time)

select *
from final
