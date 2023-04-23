with
    source as (select * from {{ ref("int_group_by_invocation_status_type") }}),
    group_by_airflow_run as (

        select
            sync_name,
            partner_name,
            airflow_run_id,
            count(distinct invocation_id) as num_steps,
            min(run_started_at) as run_started_at,
            max(run_completed_at) as run_completed_at,
            coalesce(
                sum(
                    case
                        when resource_type = 'test' and status not in ('pass', 'warn')
                        then count
                    end
                ),
                0
            ) as test_errors,
            coalesce(
                sum(
                    case
                        when resource_type = 'model' and status not in ('success')
                        then count
                    end
                ),
                0
            ) as model_errors,
            coalesce(
                sum(case when resource_type = 'test' then count end), 0
            ) as total_tests,
            coalesce(
                sum(case when resource_type = 'model' then count end), 0
            ) as total_models
        from source
        group by 1, 2, 3
    ),

    final as (select * from group_by_airflow_run)

select *
from final
