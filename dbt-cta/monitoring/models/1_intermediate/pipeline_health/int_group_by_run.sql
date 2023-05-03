with
    source as (select * from {{ ref("int_group_by_invocation") }}
    -- We only want the most recent "invocation_type" per invocation
    where most_recent_invocation_type = 1),
    group_by_airflow_run as (

        select
            sync_name,
            partner_name,
            airflow_run_id,
            count(distinct invocation_id) as num_steps,
            min(run_started_at) as run_started_at,
            max(run_completed_at) as run_completed_at,
            coalesce(sum(test_errors),0) as test_errors,
            coalesce(sum(total_tests),0) as total_tests,
            coalesce(sum(model_errors),0) as model_errors,
            coalesce(sum(total_models),0) as total_models,
        from source
        group by 1, 2, 3
    ),

    final as (select * from group_by_airflow_run)

select *
from final
