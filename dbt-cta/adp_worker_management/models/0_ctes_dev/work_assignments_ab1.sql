{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_workers') }}

SELECT
	JSON_EXTRACT_SCALAR(t._airbyte_data,'$.associateOID') as associateOID,
	JSON_EXTRACT_SCALAR(workAssignments, '$.itemID') AS itemID,
	JSON_EXTRACT_SCALAR(workAssignments, '$.primaryIndicator') AS primaryIndicator, --BOOL
	JSON_EXTRACT_SCALAR(workAssignments, '$.hireDate') AS hireDate, --DATE
	JSON_EXTRACT_SCALAR(workAssignments, '$.actualStartDate') AS actualStartDate, --DATE
	JSON_EXTRACT_SCALAR(workAssignments, '$.assignmentStatus.statusCode.codeValue') AS assignmentStatus_statusCode_codeValue,
	JSON_EXTRACT_SCALAR(workAssignments, '$.assignmentStatus.statusCode.shortName') AS assignmentStatus_statusCode_shortName,
	JSON_EXTRACT_SCALAR(workAssignments, '$.workerTypeCode.codeValue') AS workerTypeCode_codeValue,
	JSON_EXTRACT_SCALAR(workAssignments, '$.workerTypeCode.shortName') AS workerTypeCode_shortName,
	JSON_EXTRACT_SCALAR(workAssignments, '$.jobCode.codeValue') AS jobCode_codeValue,
	JSON_EXTRACT_SCALAR(workAssignments, '$.jobCode.shortName') AS jobCode_shortName,
	JSON_EXTRACT_SCALAR(workAssignments, '$.jobTitle') AS jobTitle,
	JSON_EXTRACT_SCALAR(workAssignments, '$.wageLawCoverage.wageLawNameCode.codeValue') AS wageLawCoverage_wageLawNameCode_codeValue,
	JSON_EXTRACT_SCALAR(workAssignments, '$.wageLawCoverage.wageLawNameCode.longName') AS wageLawCoverage_wageLawNameCode_longName,
	JSON_EXTRACT_SCALAR(workAssignments, '$.wageLawCoverage.coverageCode.codeValue') AS wageLawCoverage_coverageCode_codeValue,
	JSON_EXTRACT_SCALAR(workAssignments, '$.wageLawCoverage.coverageCode.shortName') AS wageLawCoverage_coverageCode_shortName,
	JSON_EXTRACT_SCALAR(workAssignments, '$.positionID') AS positionID,
	JSON_EXTRACT_SCALAR(workAssignments, '$.payCycleCode.codeValue') AS payCycleCode_codeValue,
	JSON_EXTRACT_SCALAR(workAssignments, '$.payCycleCode.shortName') AS payCycleCode_shortName,
	JSON_EXTRACT_SCALAR(workAssignments, '$.standardPayPeriodHours.hoursQuantity') AS standardPayPeriodHours_hoursQuantity, --INTEGER
	JSON_EXTRACT_SCALAR(workAssignments, '$.baseRemuneration.payPeriodRateAmount.nameCode.codeValue') AS baseRemuneration_payPeriodRateAmount_nameCode_codeValue,
	JSON_EXTRACT_SCALAR(workAssignments, '$.baseRemuneration.payPeriodRateAmount.nameCode.shortName') AS baseRemuneration_payPeriodRateAmount_nameCode_shortName,
	JSON_EXTRACT_SCALAR(workAssignments, '$.baseRemuneration.payPeriodRateAmount.amountValue') AS baseRemuneration_payPeriodRateAmount_amountValue, --INTEGER
	JSON_EXTRACT_SCALAR(workAssignments, '$.baseRemuneration.payPeriodRateAmount.currencyCode') AS baseRemuneration_payPeriodRateAmount_currencyCode,
	JSON_EXTRACT_SCALAR(workAssignments, '$.baseRemuneration.effectiveDate') AS baseRemuneration_effectiveDate, --DATE
	JSON_EXTRACT_SCALAR(workAssignments, '$.payrollGroupCode') AS payrollGroupCode,
	JSON_EXTRACT_SCALAR(workAssignments, '$.payrollScheduledGroupID') AS payrollScheduledGroupID,
	JSON_EXTRACT_SCALAR(workAssignments, '$.payrollFileNumber') AS payrollFileNumber,
	JSON_EXTRACT_SCALAR(workAssignments, '$.managementPositionIndicator') AS managementPositionIndicator, --BOOL
	--ARRAYS - these need further unnesting
	JSON_EXTRACT_ARRAY(workAssignments, '$.homeOrganizationalUnits') AS homeOrganizationalUnits,
	JSON_EXTRACT_ARRAY(workAssignments, '$.assignedOrganizationalUnits') AS assignedOrganizationalUnits,
	t._airbyte_ab_id,
	t._airbyte_emitted_at
FROM {{ source('cta', '_airbyte_raw_workers') }} as t,
  UNNEST(JSON_EXTRACT_ARRAY(_airbyte_data, '$.workAssignments')) AS workAssignments
where 1 = 1