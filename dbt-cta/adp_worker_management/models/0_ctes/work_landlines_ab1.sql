{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_workers') }}

select
    t._airbyte_ab_id,
    t._airbyte_emitted_at,
    json_extract_scalar(t._airbyte_data, '$.associateOID') as associateOID,
    json_extract_scalar(work_landlines, '$.itemID') as itemID,
    json_extract_scalar(work_landlines, '$.nameCode.codeValue') as nameCode_codeValue,
    json_extract_scalar(work_landlines, '$.nameCode.shortName') as nameCode_shortName,
    json_extract_scalar(work_landlines, '$.countryDialing') as countryDialing,
    json_extract_scalar(work_landlines, '$.areaDialing') as areaDialing,
    json_extract_scalar(work_landlines, '$.dialNumber') as dialNumber,
    json_extract_scalar(work_landlines, '$.access') as `access`,
    json_extract_scalar(work_landlines, '$.formattedNumber') as formattedNumber
from {{ source('cta', '_airbyte_raw_workers') }} as t,
    unnest(json_extract_array(_airbyte_data, '$.businessCommunication.landlines')) as work_landlines
where 1 = 1
