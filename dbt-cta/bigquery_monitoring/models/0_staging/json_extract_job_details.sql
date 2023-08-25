select
    resource.labels.project_id as projectId,
    protopayload_auditlog.authenticationInfo.principalEmail as principalEmail,
    protopayload_auditlog.requestMetadata.callerSuppliedUserAgent as userAgent,
    resource.type as resource_type,
    cast(
        json_extract_scalar(
            protopayload_auditlog.metadataJson,
            "$.jobChange.job.jobStats.queryStats.totalProcessedBytes"
        ) as int64
    ) as totalProcessedBytes,
    cast(
        json_extract_scalar(
            protopayload_auditlog.metadataJson,
            "$.jobChange.job.jobStats.queryStats.totalBilledBytes"
        ) as int64
    ) as totalBilledBytes,
    cast((cast(json_extract_scalar(
        protopayload_auditlog.metadataJson,
        "$.jobChange.job.jobStats.queryStats.totalBilledBytes"
    ) as int64) / 1000000000000) * 6.25 as numeric) as totalCostUSD,
    timestamp(json_extract_scalar(
        protopayload_auditlog.metadataJson,
        "$.jobChange.job.jobStats.createTime"
    )) as createTime,
    json_extract_scalar(
        protopayload_auditlog.metadataJson,
        "$.jobChange.job.jobName"
    ) as jobName,
    array_reverse(split(json_extract_scalar(
        protopayload_auditlog.metadataJson,
        "$.jobChange.job.jobName"
    ), "/"))[offset(0)] as jobId,
    json_extract_array(
        protopayload_auditlog.metadataJson,
        "$.jobChange.job.jobStats.queryStats.referencedTables"
    ) as referencedTables,
    json_extract_scalar(
        protopayload_auditlog.metadataJson,
        "$.jobChange.job.jobConfig.queryConfig.query"
    ) as query,
    json_extract_scalar(
        protopayload_auditlog.metadataJson,
        "$.jobChange.job.jobStats.totalSlotMs"
    ) as totalSlotMs
from
    {{ ref('filtered_logs') }}
