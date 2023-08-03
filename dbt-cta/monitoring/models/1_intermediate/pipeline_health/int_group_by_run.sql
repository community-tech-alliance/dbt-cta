with
    source as (select * from {{ ref("int_group_by_invocation") }}),
    group_by_airflow_run as (

        select
            project_id,
            sync_name,
            partner_name,
            airflow_run_id,
            count(distinct invocation_type) as num_steps,
            count(distinct invocation_id) as num_steps_run,
            min(run_started_at) as run_started_at,
            max(run_completed_at) as run_completed_at,
            coalesce(sum(case when most_recent_invocation_type = 1 then test_errors else null end),0) as test_errors,
            coalesce(sum(case when most_recent_invocation_type = 1 then total_tests else null end),0) as total_tests,
            coalesce(sum(case when most_recent_invocation_type = 1 then model_errors else null end),0) as model_errors,
            coalesce(sum(case when most_recent_invocation_type = 1 then total_models else null end),0) as total_models,
            string_agg(error_message, '\n') as error_message
        from source
        group by 1, 2, 3, 4
    ),

    final as (select * from group_by_airflow_run)

select *
from final
