{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_workers') }}

select
    t._airbyte_ab_id,
    t._airbyte_emitted_at,
    json_extract_scalar(t._airbyte_data, '$.associateOID') as associateOID, --BOOL
    json_extract_scalar(workAssignments, '$.itemID') as itemID, --DATE
    json_extract_scalar(workAssignments, '$.primaryIndicator') as primaryIndicator, --DATE
    json_extract_scalar(workAssignments, '$.hireDate') as hireDate,
    json_extract_scalar(workAssignments, '$.actualStartDate') as actualStartDate,
    json_extract_scalar(workAssignments, '$.assignmentStatus.statusCode.codeValue') as assignmentStatus_statusCode_codeValue,
    json_extract_scalar(workAssignments, '$.assignmentStatus.statusCode.shortName') as assignmentStatus_statusCode_shortName,
    json_extract_scalar(workAssignments, '$.workerTypeCode.codeValue') as workerTypeCode_codeValue,
    json_extract_scalar(workAssignments, '$.workerTypeCode.shortName') as workerTypeCode_shortName,
    json_extract_scalar(workAssignments, '$.jobCode.codeValue') as jobCode_codeValue,
    json_extract_scalar(workAssignments, '$.jobCode.shortName') as jobCode_shortName,
    json_extract_scalar(workAssignments, '$.jobTitle') as jobTitle,
    json_extract_scalar(workAssignments, '$.wageLawCoverage.wageLawNameCode.codeValue') as wageLawCoverage_wageLawNameCode_codeValue,
    json_extract_scalar(workAssignments, '$.wageLawCoverage.wageLawNameCode.longName') as wageLawCoverage_wageLawNameCode_longName,
    json_extract_scalar(workAssignments, '$.wageLawCoverage.coverageCode.codeValue') as wageLawCoverage_coverageCode_codeValue,
    json_extract_scalar(workAssignments, '$.wageLawCoverage.coverageCode.shortName') as wageLawCoverage_coverageCode_shortName,
    json_extract_scalar(workAssignments, '$.positionID') as positionID,
    json_extract_scalar(workAssignments, '$.payCycleCode.codeValue') as payCycleCode_codeValue, --INTEGER
    json_extract_scalar(workAssignments, '$.payCycleCode.shortName') as payCycleCode_shortName,
    json_extract_scalar(workAssignments, '$.standardPayPeriodHours.hoursQuantity') as standardPayPeriodHours_hoursQuantity,
    json_extract_scalar(workAssignments, '$.baseRemuneration.payPeriodRateAmount.nameCode.codeValue') as baseRemuneration_payPeriodRateAmount_nameCode_codeValue, --INTEGER
    json_extract_scalar(workAssignments, '$.baseRemuneration.payPeriodRateAmount.nameCode.shortName') as baseRemuneration_payPeriodRateAmount_nameCode_shortName,
    json_extract_scalar(workAssignments, '$.baseRemuneration.payPeriodRateAmount.amountValue') as baseRemuneration_payPeriodRateAmount_amountValue, --DATE
    json_extract_scalar(workAssignments, '$.baseRemuneration.payPeriodRateAmount.currencyCode') as baseRemuneration_payPeriodRateAmount_currencyCode,
    json_extract_scalar(workAssignments, '$.baseRemuneration.effectiveDate') as baseRemuneration_effectiveDate,
    json_extract_scalar(workAssignments, '$.payrollGroupCode') as payrollGroupCode,
    json_extract_scalar(workAssignments, '$.payrollScheduledGroupID') as payrollScheduledGroupID, --BOOL
    --ARRAYS - these need further unnesting
    json_extract_scalar(workAssignments, '$.payrollFileNumber') as payrollFileNumber,
    json_extract_scalar(workAssignments, '$.managementPositionIndicator') as managementPositionIndicator,
    json_extract_array(workAssignments, '$.homeOrganizationalUnits') as homeOrganizationalUnits,
    json_extract_array(workAssignments, '$.assignedOrganizationalUnits') as assignedOrganizationalUnits
from {{ source('cta', '_airbyte_raw_workers') }} as t,
    unnest(json_extract_array(_airbyte_data, '$.workAssignments')) as workAssignments
where 1 = 1
