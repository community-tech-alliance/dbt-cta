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
            inv.invocation_id,
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
            run.rows_affected

        from filter_invocations as inv
        left join run_results run using (invocation_id)
    ),
    group_by_invocation_status_type as (
        select
            invocation_id,
            run_started_at,
            run_completed_at,
            command,
            target_name,
            selected,
            sync_name,
            partner_name,
            airflow_run_id,
            resource_type,
            status,
            count(*) as count
        from join_run_results
        group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11

    ),
    final as (select * from group_by_invocation_status_type)

select *
from final
