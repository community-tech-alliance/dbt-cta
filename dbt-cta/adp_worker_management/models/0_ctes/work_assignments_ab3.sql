{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_work_assignments_hashid'
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('work_assignments_ab2') }}

select
    {{ dbt_utils.surrogate_key([
        'itemID',
        'primaryIndicator',
        'hireDate',
        'actualStartDate',
        'assignmentStatus_statusCode_codeValue',
        'assignmentStatus_statusCode_shortName',
        'workerTypeCode_codeValue',
        'workerTypeCode_shortName',
        'jobCode_codeValue',
        'jobCode_shortName',
        'jobTitle',
        'wageLawCoverage_wageLawNameCode_codeValue',
        'wageLawCoverage_wageLawNameCode_longName',
        'wageLawCoverage_coverageCode_codeValue',
        'wageLawCoverage_coverageCode_shortName',
        'positionID',
        'payCycleCode_codeValue',
        'payCycleCode_shortName',
        'standardPayPeriodHours_hoursQuantity',
        'baseRemuneration_payPeriodRateAmount_nameCode_codeValue',
        'baseRemuneration_payPeriodRateAmount_nameCode_shortName',
        'baseRemuneration_payPeriodRateAmount_amountValue',
        'baseRemuneration_payPeriodRateAmount_currencyCode',
        'baseRemuneration_effectiveDate',
        'payrollGroupCode',
        'payrollScheduledGroupID',
        'payrollFileNumber',
        'managementPositionIndicator',
    ]) }} as _airbyte_work_assignments_hashid,
    tmp.*
from {{ ref('work_assignments_ab2') }} tmp

where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

