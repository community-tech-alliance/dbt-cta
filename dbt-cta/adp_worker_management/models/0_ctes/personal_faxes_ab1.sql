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
    json_extract_scalar(personal_faxes, '$.itemID') as itemID,
    json_extract_scalar(personal_faxes, '$.nameCode.codeValue') as nameCode_codeValue,
    json_extract_scalar(personal_faxes, '$.nameCode.shortName') as nameCode_shortName,
    json_extract_scalar(personal_faxes, '$.countryDialing') as countryDialing,
    json_extract_scalar(personal_faxes, '$.areaDialing') as areaDialing,
    json_extract_scalar(personal_faxes, '$.dialNumber') as dialNumber,
    json_extract_scalar(personal_faxes, '$.access') as `access`,
    json_extract_scalar(personal_faxes, '$.formattedNumber') as formattedNumber
from {{ source('cta_raw', raw_table) }} as t,
    unnest(json_extract_array(_airbyte_data, '$.person.communication.faxes')) as personal_faxes
where 1 = 1
