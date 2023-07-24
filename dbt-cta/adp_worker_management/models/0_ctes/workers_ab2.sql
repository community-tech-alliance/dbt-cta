{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('workers_ab1') }}

select
	-- SCALAR values (one per worker ID)
	cast(associateOID as {{ dbt_utils.type_string() }}) as associateOID,
	cast(workerID_idValue as {{ dbt_utils.type_string() }}) as workerID_idValue,
	cast(birthDate as {{ dbt_utils.type_string() }}) as birthDate,
	cast(genderCode_codeValue as {{ dbt_utils.type_string() }}) as genderCode_codeValue,
	cast(genderCode_shortName as {{ dbt_utils.type_string() }}) as genderCode_shortName,
	cast(genderCode_longName as {{ dbt_utils.type_string() }}) as genderCode_longName,
	cast(maritalStatusCode_codeValue as {{ dbt_utils.type_string() }}) as maritalStatusCode_codeValue,
	cast(maritalStatusCode_shortName as {{ dbt_utils.type_string() }}) as maritalStatusCode_shortName,
	cast(tobaccoUserIndicator as {{ dbt_utils.type_string() }}) as tobaccoUserIndicator,
	cast(disabledIndicator as {{ dbt_utils.type_string() }}) as disabledIndicator,
	cast(ethnicityCode_codeValue as {{ dbt_utils.type_string() }}) as ethnicityCode_codeValue,
	cast(ethnicityCode_shortName as {{ dbt_utils.type_string() }}) as ethnicityCode_shortName,
	cast(ethnicityCode_longName as {{ dbt_utils.type_string() }}) as ethnicityCode_longName,
	cast(raceCode_codeValue as {{ dbt_utils.type_string() }}) as raceCode_codeValue,
	cast(raceCode_shortName as {{ dbt_utils.type_string() }}) as raceCode_shortName,
	cast(raceCode_longName as {{ dbt_utils.type_string() }}) as raceCode_longName,
	cast(givenName as {{ dbt_utils.type_string() }}) as givenName,
	cast(middleName as {{ dbt_utils.type_string() }}) as middleName,
	cast(familyName1 as {{ dbt_utils.type_string() }}) as familyName1,
	cast(formattedName as {{ dbt_utils.type_string() }}) as formattedName,
	cast(legalAddress_nameCade_codeValue as {{ dbt_utils.type_string() }}) as legalAddress_nameCade_codeValue,
	cast(legalAddress_nameCade_shortName as {{ dbt_utils.type_string() }}) as legalAddress_nameCade_shortName,
	cast(legalAddress_lineOne as {{ dbt_utils.type_string() }}) as legalAddress_lineOne,
	cast(legalAddress_lineTwo as {{ dbt_utils.type_string() }}) as legalAddress_lineTwo,
	cast(legalAddress_lineThree as {{ dbt_utils.type_string() }}) as legalAddress_lineThree,
	cast(legalAddress_cityName as {{ dbt_utils.type_string() }}) as legalAddress_cityName,
	cast(legalAddress_countrySubdivisionLevel1_subdivisionType as {{ dbt_utils.type_string() }}) as legalAddress_countrySubdivisionLevel1_subdivisionType,
	cast(legalAddress_countrySubdivisionLevel1_codeValue as {{ dbt_utils.type_string() }}) as legalAddress_countrySubdivisionLevel1_codeValue,
	cast(legalAddress_countrySubdivisionLevel1_shortName as {{ dbt_utils.type_string() }}) as legalAddress_countrySubdivisionLevel1_shortName,
	cast(legalAddress_countryCode as {{ dbt_utils.type_string() }}) as legalAddress_countryCode,
	cast(legalAddress_postalCode as {{ dbt_utils.type_string() }}) as legalAddress_postalCode,
	cast({{ empty_string_to_null('originalHireDate') }} as {{ type_date() }}) as originalHireDate,
	cast(workerStatus_statusCode_codeValue as {{ dbt_utils.type_string() }}) as workerStatus_statusCode_codeValue,
	
	-- ARRAYS (potentially multiple per worker ID; need to unnest)
	socialInsurancePrograms,
	governmentIDs,
	personal_landlines,
	personal_mobiles,
	personal_emails,
	personal_faxes,
	work_landlines,
	work_mobiles,
	work_emails,
	work_faxes,
	work_pagers,
	workAssignments,
    _airbyte_ab_id,
    _airbyte_emitted_at
from {{ ref('workers_ab1') }} as table_alias
where 1 = 1