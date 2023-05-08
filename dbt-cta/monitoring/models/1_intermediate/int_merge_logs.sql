with
    composer_logs as (select * from {{ ref("int_parse_scheduler_logs") }}),

    elementary_logs as (select * from {{ ref("int_parse_elementary_logs") }}),

    exclude_elementary_logs as (
        select *
        from composer_logs cl
        left join elementary_logs el on cl.run_id = el.airflow_run_id
        where el.airflow_run_id is null
        order by received_timestamp
    ),
    
    union_sources as (
        select
            dag_id as sync_name,
            null as partner_name,
            run_id,
            run_start_date as run_started_at,
            run_end_date as run_finished_at,
            state as run_status,
            null as num_rows_affected,
            null as num_rows_updated,
            null as num_rows_added,
            null as data_source_type,
            null as data_source,
            'composer' as log_source

        from exclude_elementary_logs

        union all

        select
            sync_name,
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
