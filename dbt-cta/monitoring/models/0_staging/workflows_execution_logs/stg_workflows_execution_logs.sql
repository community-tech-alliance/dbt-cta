with
    source as (select * from {{ source("workflows_logs", "executions") }}),
    unpack_nested_fields as (
        select
            * except (logName, resource, textPayload, jsonpayload_type_executionssystemlog),
            JSON_EXTRACT_SCALAR(jsonpayload_type_executionssystemlog.start.argument,'$.partner_name') as partner_name,
            resource.type as resource_type,
            resource.labels.resource_container as resource_container,
            resource.labels.location as location,
            resource.labels.workflow_id as workflow_id,
            labels.workflows_googleapis_com_execution_id as execution_id,
            labels.workflows_googleapis_com_revision_id as revision_id,
            jsonpayload_type_executionssystemlog.state as state,
            jsonpayload_type_executionssystemlog.start.argument as arguments,
            jsonpayload_type_executionssystemlog.failure.source as failure_source,
            jsonpayload_type_executionssystemlog.failure.exception as failure_exception,
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
