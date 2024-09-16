{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('work_assignments_ab3') }}

select
    t.associateOID,
    t.itemID,
    t._airbyte_raw_id,
    t._airbyte_extracted_at,
    json_extract_scalar(homeOrganizationalUnits, '$.nameCode.codeValue') as nameCode_codeValue,
    json_extract_scalar(homeOrganizationalUnits, '$.nameCode.shortName') as nameCode_shortName,
    json_extract_scalar(homeOrganizationalUnits, '$.typeCode.codeValue') as typeCode_codeValue,
    json_extract_scalar(homeOrganizationalUnits, '$.typeCode.shortName') as typeCode_shortName
from {{ ref('work_assignments_ab3') }} as t,
    unnest(homeOrganizationalUnits) as homeOrganizationalUnits
where 1 = 1
