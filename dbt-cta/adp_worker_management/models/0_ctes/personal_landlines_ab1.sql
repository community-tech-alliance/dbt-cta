{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_workers') }}

SELECT
	JSON_EXTRACT_SCALAR(t._airbyte_data,'$.associateOID') as associateOID,
	JSON_EXTRACT_SCALAR(personal_landlines, '$.itemID') AS itemID,
	JSON_EXTRACT_SCALAR(personal_landlines, '$.nameCode.codeValue') AS nameCode_codeValue,
	JSON_EXTRACT_SCALAR(personal_landlines, '$.nameCode.shortName') AS nameCode_shortName,
	JSON_EXTRACT_SCALAR(personal_landlines, '$.countryDialing') AS countryDialing,
	JSON_EXTRACT_SCALAR(personal_landlines, '$.areaDialing') AS areaDialing,
	JSON_EXTRACT_SCALAR(personal_landlines, '$.dialNumber') AS dialNumber,
	JSON_EXTRACT_SCALAR(personal_landlines, '$.access') AS `access`,
	JSON_EXTRACT_SCALAR(personal_landlines, '$.formattedNumber') AS formattedNumber,
	t._airbyte_ab_id,
    t._airbyte_emitted_at
FROM {{ source('cta', '_airbyte_raw_workers') }} as t,
  UNNEST(JSON_EXTRACT_ARRAY(_airbyte_data, '$.person.communication.landlines')) AS personal_landlines
where 1 = 1