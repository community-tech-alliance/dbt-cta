with
    composer_logs as (select * from {{ ref("int_group_scheduler_logs_by_dag") }}),

    elementary_logs as (select * from {{ ref("int_group_by_run") }}),

    /*
        We need to exclude composer logs that are already present in elementary logs,
        which we do by joining on airflow run ID. This means that if elementary fails
        to upload logs for whatever reason, we'll fall back on the composer status.
    */
    exclude_elementary_logs as (
        select cl.*
        from composer_logs cl
        left join elementary_logs el on cl.run_id = el.airflow_run_id
        where el.airflow_run_id is null
    ),

    union_sources as (
        select
            sync_name,
            dag_id,
            partner_name,
            run_id,
            run_start_date as run_started_at,
            run_end_date as run_finished_at,
            state as run_status,
            null as num_rows_affected,
            null as num_rows_updated,
            null as num_rows_added,
            data_source_type,
            null as data_source,
            'composer' as log_source

        from exclude_elementary_logs

        union all

        select
            sync_name,
            sync_name as dag_id,
            partner_name as partner_name,
            airflow_run_id as run_id,
            run_started_at as run_started_at,
            run_completed_at as run_finished_at,
            case
                when test_errors > 0 or model_errors > 0 then 'failed' else 'success'
            end as run_status,
            null as num_rows_affected,
            null as num_rows_updated,
            null as num_rows_added,
            null as data_source_type,
            null as data_source,
            'elementary' as log_source

        from elementary_logs

    )

select *
from union_sources
