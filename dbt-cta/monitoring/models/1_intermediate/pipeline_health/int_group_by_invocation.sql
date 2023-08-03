with
    invocations as (select * from {{ ref("stg_elementary__dbt_invocations") }}),
    run_results as (select * from {{ ref("stg_elementary__dbt_run_results") }}),
    filter_invocations as (
        select *
        from invocations
        -- filter out invocations that are not part of an airflow run
        where airflow_run_id is not null
    ),
    join_run_results as (
        select
            inv.project_id,
            inv.invocation_id,
            inv.invocation_type,
            inv.command,
            inv.run_started_at,
            inv.run_completed_at,
            inv.target_name,
            inv.selected,
            inv.sync_name,
            inv.partner_name,
            inv.airflow_run_id,
            run.resource_type,
            run.status,
            run.failures,
            run.rows_affected,
            run.message,
            run.compiled_code,
            case when run.status != 'success' then concat(run.name||': '||run.message)
            else null end as error_message

        from filter_invocations as inv
        left join run_results run using (invocation_id)
    ),
    group_by_invocation as (
        select
            project_id,
            invocation_id,
            invocation_type,
            run_started_at,
            run_completed_at,
            command,
            target_name,
            selected,
            sync_name,
            partner_name,
            airflow_run_id,
            coalesce(
                sum(
                    case
                        when resource_type = 'test' and status not in ('pass', 'warn')
                        then 1
                    end
                ),
                0
            ) as test_errors,
            coalesce(
                sum(
                    case
                        when resource_type = 'model' and status not in ('success')
                        then 1
                    end
                ),
                0
            ) as model_errors,
            coalesce(
                sum(case when resource_type = 'test' then 1 end), 0
            ) as total_tests,
            coalesce(
                sum(case when resource_type = 'model' then 1 end), 0
            ) as total_models
            , string_agg(error_message,'\n ') as error_message
        from join_run_results
        group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11

    ),
    compute_most_recent_invocation_per_type as (
        select * 
        , row_number() over (partition by invocation_type, sync_name, partner_name, airflow_run_id order by run_started_at desc) as most_recent_invocation_type
        from group_by_invocation
    ),
    final as (select * from compute_most_recent_invocation_per_type)

select *
from final
