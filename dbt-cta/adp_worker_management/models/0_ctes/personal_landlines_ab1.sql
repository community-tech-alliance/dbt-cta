{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_workers" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}

select
    t._airbyte_raw_id,
    t._airbyte_extracted_at,
    json_extract_scalar(t._airbyte_data, '$.associateOID') as associateOID,
    json_extract_scalar(personal_landlines, '$.itemID') as itemID,
    json_extract_scalar(personal_landlines, '$.nameCode.codeValue') as nameCode_codeValue,
    json_extract_scalar(personal_landlines, '$.nameCode.shortName') as nameCode_shortName,
    json_extract_scalar(personal_landlines, '$.countryDialing') as countryDialing,
    json_extract_scalar(personal_landlines, '$.areaDialing') as areaDialing,
    json_extract_scalar(personal_landlines, '$.dialNumber') as dialNumber,
    json_extract_scalar(personal_landlines, '$.access') as `access`,
    json_extract_scalar(personal_landlines, '$.formattedNumber') as formattedNumber
from {{ source('cta_raw', raw_table) }} as t,
    unnest(json_extract_array(_airbyte_data, '$.person.communication.landlines')) as personal_landlines
where 1 = 1
