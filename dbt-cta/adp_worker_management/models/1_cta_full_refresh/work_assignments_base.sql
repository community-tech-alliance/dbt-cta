{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_work_assignments_hashid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('work_assignments_ab4') }}

select
    itemID,
    primaryIndicator,
    hireDate,
    actualStartDate,
    assignmentStatus_statusCode_codeValue,
    assignmentStatus_statusCode_shortName,
    workerTypeCode_codeValue,
    workerTypeCode_shortName,
    jobCode_codeValue,
    jobCode_shortName,
    jobTitle,
    wageLawCoverage_wageLawNameCode_codeValue,
    wageLawCoverage_wageLawNameCode_longName,
    wageLawCoverage_coverageCode_codeValue,
    wageLawCoverage_coverageCode_shortName,
    positionID,
    payCycleCode_codeValue,
    payCycleCode_shortName,
    standardPayPeriodHours_hoursQuantity,
    baseRemuneration_payPeriodRateAmount_nameCode_codeValue,
    baseRemuneration_payPeriodRateAmount_nameCode_shortName,
    baseRemuneration_payPeriodRateAmount_amountValue,
    baseRemuneration_payPeriodRateAmount_currencyCode,
    baseRemuneration_effectiveDate,
    payrollGroupCode,
    payrollScheduledGroupID,
    payrollFileNumber,
    managementPositionIndicator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_work_assignments_hashid
from {{ ref('work_assignments_ab4') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
