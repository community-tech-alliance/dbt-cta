with
    source as (select * from {{ ref("int_parse_scheduler_logs") }}),
    add_most_recent_flag as (
        select
            *,
            row_number() over (
                partition by dag_id, run_id, partner_name order by log_timestamp desc
            ) as most_recent
        from source
    ),
    group_by_run as (
        select

            dag_id,
            run_id,
            partner_name

            {% set most_recent_fields = [
                "log_timestamp",
                "received_timestamp",
                "state",
                "external_trigger",
                "run_type",
                "project_id",
                "environment_name",
                "execution_date",
                "sync_name",
                "data_source_type"
            ] %}
            {% for field in most_recent_fields %}

            , max(case when most_recent = 1 then {{ field }} end) as {{ field }}

            {% endfor %},
            min(data_interval_start) as data_interval_start,
            max(data_interval_end) as data_interval_end,
            min(run_start_date) as run_start_date,
            max(run_end_date) as run_end_date,
            -- TODO: should we actually be calculating this?
            sum(run_duration) as run_duration,
            array_agg(dag_hash) as dag_hash,
            array_agg(insert_id) as insert_id

        from add_most_recent_flag
        group by 1, 2, 3
    )

select *
from group_by_run
