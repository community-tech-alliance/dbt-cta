select distinct
    json_extract_scalar(
        protopayload_auditlog.metadataJson,
        "$.jobChange.job.jobName"
    ) as jobName
from
    {{ ref('filtered_logs') }}
