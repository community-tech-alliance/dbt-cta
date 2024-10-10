{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_workers" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}

select

    -- SCALAR values (one per worker ID)
    _airbyte_raw_id,
    _airbyte_extracted_at,
    json_extract_scalar(_airbyte_data, '$.associateOID') as associateOID,
    json_extract_scalar(_airbyte_data, '$.workerID.idValue') as workerID_idValue,
    json_extract_scalar(_airbyte_data, '$.person.birthDate') as birthDate,
    json_extract_scalar(_airbyte_data, '$.person.genderCode.codeValue') as genderCode_codeValue,
    json_extract_scalar(_airbyte_data, '$.person.genderCode.shortName') as genderCode_shortName,
    json_extract_scalar(_airbyte_data, '$.person.genderCode.longName') as genderCode_longName,
    json_extract_scalar(_airbyte_data, '$.person.maritalStatusCode.codeValue') as maritalStatusCode_codeValue,
    json_extract_scalar(_airbyte_data, '$.person.maritalStatusCode.shortName') as maritalStatusCode_shortName,
    json_extract_scalar(_airbyte_data, '$.person.tobaccoUserIndicator') as tobaccoUserIndicator,
    json_extract_scalar(_airbyte_data, '$.person.disabledIndicator') as disabledIndicator,
    json_extract_scalar(_airbyte_data, '$.person.ethnicityCode.codeValue') as ethnicityCode_codeValue,
    json_extract_scalar(_airbyte_data, '$.person.ethnicityCode.shortName') as ethnicityCode_shortName,
    json_extract_scalar(_airbyte_data, '$.person.ethnicityCode.longName') as ethnicityCode_longName,
    json_extract_scalar(_airbyte_data, '$.person.raceCode.codeValue') as raceCode_codeValue,
    json_extract_scalar(_airbyte_data, '$.person.raceCode.shortName') as raceCode_shortName,
    json_extract_scalar(_airbyte_data, '$.person.raceCode.longName') as raceCode_longName,
    json_extract_scalar(_airbyte_data, '$.person.legalName.givenName') as givenName,
    json_extract_scalar(_airbyte_data, '$.person.legalName.middleName') as middleName,
    json_extract_scalar(_airbyte_data, '$.person.legalName.familyName1') as familyName1,
    json_extract_scalar(_airbyte_data, '$.person.legalName.formattedName') as formattedName,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.nameCode.codeValue') as legalAddress_nameCade_codeValue,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.nameCode.shortName') as legalAddress_nameCade_shortName,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.lineOne') as legalAddress_lineOne,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.lineTwo') as legalAddress_lineTwo,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.lineThree') as legalAddress_lineThree,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.cityName') as legalAddress_cityName,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.countrySubdivisionLevel1.subdivisionType') as legalAddress_countrySubdivisionLevel1_subdivisionType,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.countrySubdivisionLevel1.codeValue') as legalAddress_countrySubdivisionLevel1_codeValue,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.countrySubdivisionLevel1.shortName') as legalAddress_countrySubdivisionLevel1_shortName,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.countryCode') as legalAddress_countryCode,
    json_extract_scalar(_airbyte_data, '$.person.legalAddress.postalCode') as legalAddress_postalCode,

    -- ARRAYS (potentially multiple per worker ID; need to unnest)
    json_extract_scalar(_airbyte_data, '$.workerDates.originalHireDate') as originalHireDate,
    json_extract_scalar(_airbyte_data, '$.workerStatus.statusCode.codeValue') as workerStatus_statusCode_codeValue,
    json_extract_array(_airbyte_data, '$.person.socialInsurancePrograms') as socialInsurancePrograms,
    json_extract_array(_airbyte_data, '$.person.governmentIDs') as governmentIDs,
    json_extract_array(_airbyte_data, '$.person.communication.landlines') as personal_landlines,
    json_extract_array(_airbyte_data, '$.person.communication.mobiles') as personal_mobiles,
    json_extract_array(_airbyte_data, '$.person.communication.emails') as personal_emails,
    json_extract_array(_airbyte_data, '$.person.communication.faxes') as personal_faxes,
    json_extract_array(_airbyte_data, '$.businessCommunication.landlines') as work_landlines,
    json_extract_array(_airbyte_data, '$.businessCommunication.mobiles') as work_mobiles,
    json_extract_array(_airbyte_data, '$.businessCommunication.emails') as work_emails,
    json_extract_array(_airbyte_data, '$.businessCommunication.faxes') as work_faxes,
    json_extract_array(_airbyte_data, '$.businessCommunication.pagers') as work_pagers,
    json_extract_array(_airbyte_data, '$.workAssignments') as workAssignments
from {{ source('cta_raw', raw_table) }}
where 1 = 1
