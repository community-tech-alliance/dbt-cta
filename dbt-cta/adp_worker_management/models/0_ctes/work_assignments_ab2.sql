{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('work_assignments_ab1') }}

select
    cast(associateOID as {{ dbt_utils.type_string() }}) as associateOID,
    cast(itemID as {{ dbt_utils.type_string() }}) as itemID,
    cast(primaryIndicator as boolean) as primaryIndicator,
    cast({{ empty_string_to_null('hireDate') }} as {{ type_date() }}) as hireDate,
    cast({{ empty_string_to_null('actualStartDate') }} as {{ type_date() }}) as actualStartDate,
    cast(assignmentStatus_statusCode_codeValue as {{ dbt_utils.type_string() }}) as assignmentStatus_statusCode_codeValue,
    cast(assignmentStatus_statusCode_shortName as {{ dbt_utils.type_string() }}) as assignmentStatus_statusCode_shortName,
    cast(workerTypeCode_codeValue as {{ dbt_utils.type_string() }}) as workerTypeCode_codeValue,
    cast(workerTypeCode_shortName as {{ dbt_utils.type_string() }}) as workerTypeCode_shortName,
    cast(jobCode_codeValue as {{ dbt_utils.type_string() }}) as jobCode_codeValue,
    cast(jobCode_shortName as {{ dbt_utils.type_string() }}) as jobCode_shortName,
    cast(jobTitle as {{ dbt_utils.type_string() }}) as jobTitle,
    cast(wageLawCoverage_wageLawNameCode_codeValue as {{ dbt_utils.type_string() }}) as wageLawCoverage_wageLawNameCode_codeValue,
    cast(wageLawCoverage_wageLawNameCode_longName as {{ dbt_utils.type_string() }}) as wageLawCoverage_wageLawNameCode_longName,
    cast(wageLawCoverage_coverageCode_codeValue as {{ dbt_utils.type_string() }}) as wageLawCoverage_coverageCode_codeValue,
    cast(wageLawCoverage_coverageCode_shortName as {{ dbt_utils.type_string() }}) as wageLawCoverage_coverageCode_shortName,
    cast(positionID as {{ dbt_utils.type_string() }}) as positionID,
    cast(payCycleCode_codeValue as {{ dbt_utils.type_string() }}) as payCycleCode_codeValue,
    cast(payCycleCode_shortName as {{ dbt_utils.type_string() }}) as payCycleCode_shortName,
    cast(standardPayPeriodHours_hoursQuantity as {{ dbt_utils.type_int() }}) as standardPayPeriodHours_hoursQuantity,
    cast(baseRemuneration_payPeriodRateAmount_nameCode_codeValue as {{ dbt_utils.type_string() }}) as baseRemuneration_payPeriodRateAmount_nameCode_codeValue,
    cast(baseRemuneration_payPeriodRateAmount_nameCode_shortName as {{ dbt_utils.type_string() }}) as baseRemuneration_payPeriodRateAmount_nameCode_shortName,
    cast(baseRemuneration_payPeriodRateAmount_amountValue as {{ dbt_utils.type_int() }}) as baseRemuneration_payPeriodRateAmount_amountValue,
    cast(baseRemuneration_payPeriodRateAmount_currencyCode as {{ dbt_utils.type_string() }}) as baseRemuneration_payPeriodRateAmount_currencyCode,
    cast({{ empty_string_to_null('baseRemuneration_effectiveDate') }} as {{ type_date() }}) as baseRemuneration_effectiveDate,
    cast(payrollGroupCode as {{ dbt_utils.type_string() }}) as payrollGroupCode,
    cast(payrollScheduledGroupID as {{ dbt_utils.type_string() }}) as payrollScheduledGroupID,
    cast(payrollFileNumber as {{ dbt_utils.type_string() }}) as payrollFileNumber,
    cast(managementPositionIndicator as boolean) as managementPositionIndicator,
    homeOrganizationalUnits,
    assignedOrganizationalUnits,
    t._airbyte_ab_id,
    t._airbyte_emitted_at

from {{ ref('work_assignments_ab1') }} as t
where 1 = 1
