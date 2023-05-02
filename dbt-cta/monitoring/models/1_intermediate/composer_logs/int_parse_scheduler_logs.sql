with
    source as (select * from {{ ref("stg_composer_logs__scheduler") }}),

    split_log_data as (
        select *, split(textpayload, 'DagRun Finished: ')[offset(1)] as log_data
        from source
    ),

    /* The textpayload column contains a comma-separated list of key-value pairs, i.e.:
        dag_id=example_dag, execution_date=2020-01-01T00:00:00+00:00, run_id=manual__2020-01-01T00:00:00+00:00, ...
    */
    generate_struct as (
        select
            *,
            array(
                select
                    struct(
                        split(v, "=")[offset(0)] as key,
                        split(v, "=")[offset(1)] as value
                    )
                from unnest(split(log_data, ', ')) as v
            ) as log_values
        from split_log_data
    )

    {% set fields = [
    "dag_id",
    "execution_date",
    "run_id",
    "run_start_date",
    "run_end_date",
    "run_duration",
    "state",
    "external_trigger",
    "run_type",
    "data_interval_start",
    "data_interval_end",
    "dag_hash",
] %},

    unpack_values as (
        select
            insert_id,
            log_timestamp,
            received_timestamp,
            project_id,
            environment_name

            {% for field in fields %}
            ,
            (
                select value
                from unnest(generate_struct.log_values)
                where key = '{{ field }}'
            ) as {{ field }}
            {% endfor %}
        from generate_struct

    ),
    cast_data_types as (
        select
            insert_id,
            cast(log_timestamp as timestamp) as log_timestamp,
            cast(received_timestamp as timestamp) as received_timestamp,
            project_id,
            environment_name,
            dag_id,
            cast(execution_date as timestamp) as execution_date,
            run_id,
            cast(run_start_date as timestamp) as run_start_date,
            cast(run_end_date as timestamp) as run_end_date,
            cast(run_duration as float64) as run_duration,
            state,
            external_trigger,
            run_type,
            cast(data_interval_start as timestamp) as data_interval_start,
            cast(data_interval_end as timestamp) as data_interval_end,
            dag_hash

        from unpack_values
    )

select *
from cast_data_types
