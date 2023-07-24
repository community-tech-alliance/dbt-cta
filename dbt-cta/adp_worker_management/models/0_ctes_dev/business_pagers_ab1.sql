{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_workers') }}

SELECT
	JSON_EXTRACT_SCALAR(t._airbyte_data,'$.associateOID') as associateOID,
	JSON_EXTRACT_SCALAR(business_pagers, '$.itemID') AS itemID,
	JSON_EXTRACT_SCALAR(business_pagers, '$.nameCode.codeValue') AS nameCode_codeValue,
	JSON_EXTRACT_SCALAR(business_pagers, '$.nameCode.shortName') AS nameCode_shortName,
	JSON_EXTRACT_SCALAR(business_pagers, '$.countryDialing') AS countryDialing,
	JSON_EXTRACT_SCALAR(business_pagers, '$.areaDialing') AS areaDialing,
	JSON_EXTRACT_SCALAR(business_pagers, '$.dialNumber') AS dialNumber,
	JSON_EXTRACT_SCALAR(business_pagers, '$.access') AS `access`,
	JSON_EXTRACT_SCALAR(business_pagers, '$.formattedNumber') AS formattedNumber,
	t._airbyte_ab_id,
    t._airbyte_emitted_at
FROM {{ source('cta', '_airbyte_raw_workers') }} as t,
  UNNEST(JSON_EXTRACT_ARRAY(_airbyte_data, '$.businessCommunication.pagers')) AS business_pagers
where 1 = 1