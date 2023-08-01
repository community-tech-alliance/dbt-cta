with
    source as (select * from {{ source("workflows_logs", "executions") }}),
    unpack_nested_fields as (
        select
            *,
            resource.type as resource_type,
            REGEXP_EXTRACT(logName, r"/([^/]+)/logs/") AS project_id
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
