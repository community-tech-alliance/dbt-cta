{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_workers_hashid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('workers_ab4') }}

select
    associateOID,
    workerID_idValue,
    birthDate,
    genderCode_codeValue,
    genderCode_shortName,
    genderCode_longName,
    maritalStatusCode_codeValue,
    maritalStatusCode_shortName,
    tobaccoUserIndicator,
    disabledIndicator,
    ethnicityCode_codeValue,
    ethnicityCode_shortName,
    ethnicityCode_longName,
    raceCode_codeValue,
    raceCode_shortName,
    raceCode_longName,
    givenName,
    middleName,
    familyName1,
    formattedName,
    legalAddress_nameCade_codeValue,
    legalAddress_nameCade_shortName,
    legalAddress_lineOne,
    legalAddress_lineTwo,
    legalAddress_lineThree,
    legalAddress_cityName,
    legalAddress_countrySubdivisionLevel1_subdivisionType,
    legalAddress_countrySubdivisionLevel1_codeValue,
    legalAddress_countrySubdivisionLevel1_shortName,
    legalAddress_countryCode,
    legalAddress_postalCode,
    originalHireDate,
    workerStatus_statusCode_codeValue,
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_workers_hashid
from {{ ref('workers_ab4') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
