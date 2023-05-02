with
    source as (select * from {{ source("composer_logs", "airflow_scheduler") }}),
    unpack_nested_fields as (
        select
            *,
            resource.type as resource_type,
            resource.labels.project_id as project_id,
            resource.labels.environment_name as environment_name

        from source
    ),
    rename as (
        select
            * except (insertid, timestamp, receivetimestamp),
            insertid as insert_id,
            timestamp as log_timestamp,
            receivetimestamp as received_timestamp
        from unpack_nested_fields
    )

select *
from rename
