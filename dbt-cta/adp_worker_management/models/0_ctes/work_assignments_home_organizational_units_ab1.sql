{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('work_assignments_ab3') }}

SELECT
	t.associateOID as associateOID,
	t.itemID as itemID,
	JSON_EXTRACT_SCALAR(homeOrganizationalUnits, '$.nameCode.codeValue') AS nameCode_codeValue,
	JSON_EXTRACT_SCALAR(homeOrganizationalUnits, '$.nameCode.shortName') AS nameCode_shortName,
	JSON_EXTRACT_SCALAR(homeOrganizationalUnits, '$.typeCode.codeValue') AS typeCode_codeValue,
	JSON_EXTRACT_SCALAR(homeOrganizationalUnits, '$.typeCode.shortName') AS typeCode_shortName,
	t._airbyte_ab_id,
	t._airbyte_emitted_at
FROM {{ ref('work_assignments_ab3') }} as t,
  UNNEST(homeOrganizationalUnits) AS homeOrganizationalUnits
where 1 = 1