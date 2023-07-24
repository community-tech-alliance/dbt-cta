{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_workers_hashid'
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('workers_ab2') }}

select
    {{ dbt_utils.surrogate_key([
        'associateOID',
        'workerID_idValue',
        'birthDate',
        'genderCode_codeValue',
        'genderCode_shortName',
        'genderCode_longName',
        'maritalStatusCode_codeValue',
        'maritalStatusCode_shortName',
        'tobaccoUserIndicator',
        'disabledIndicator',
        'ethnicityCode_codeValue',
        'ethnicityCode_shortName',
        'ethnicityCode_longName',
        'raceCode_codeValue',
        'raceCode_shortName',
        'raceCode_longName',
        'givenName',
        'middleName',
        'familyName1',
        'formattedName',
        'legalAddress_nameCade_codeValue',
        'legalAddress_nameCade_shortName',
        'legalAddress_lineOne',
        'legalAddress_lineTwo',
        'legalAddress_lineThree',
        'legalAddress_cityName',
        'legalAddress_countrySubdivisionLevel1_subdivisionType',
        'legalAddress_countrySubdivisionLevel1_codeValue',
        'legalAddress_countrySubdivisionLevel1_shortName',
        'legalAddress_countryCode',
        'legalAddress_postalCode',
        'originalHireDate',
        'workerStatus_statusCode_codeValue',
    ]) }} as _airbyte_workers_hashid,
    tmp.*
from {{ ref('workers_ab2') }} tmp

where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

