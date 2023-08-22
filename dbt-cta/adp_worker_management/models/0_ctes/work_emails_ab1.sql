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
    json_extract_scalar(work_email, '$.nameCode.codeValue') as nameCode_codeValue,
    json_extract_scalar(work_email, '$.nameCode.shortName') as nameCode_shortName,
    json_extract_scalar(work_email, '$.emailUri') as emailUri
from {{ source('cta', '_airbyte_raw_workers') }} as t,
    unnest(json_extract_array(_airbyte_data, '$.businessCommunication.emails')) as work_email
where 1 = 1
