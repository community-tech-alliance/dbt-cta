{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_workers') }}

SELECT
	JSON_EXTRACT_SCALAR(t._airbyte_data,'$.associateOID') as associateOID,
	JSON_EXTRACT_SCALAR(business_faxes, '$.itemID') AS itemID,
	JSON_EXTRACT_SCALAR(business_faxes, '$.nameCode.codeValue') AS nameCode_codeValue,
	JSON_EXTRACT_SCALAR(business_faxes, '$.nameCode.shortName') AS nameCode_shortName,
	JSON_EXTRACT_SCALAR(business_faxes, '$.countryDialing') AS countryDialing,
	JSON_EXTRACT_SCALAR(business_faxes, '$.areaDialing') AS areaDialing,
	JSON_EXTRACT_SCALAR(business_faxes, '$.dialNumber') AS dialNumber,
	JSON_EXTRACT_SCALAR(business_faxes, '$.access') AS `access`,
	JSON_EXTRACT_SCALAR(business_faxes, '$.formattedNumber') AS formattedNumber,
	t._airbyte_ab_id,
    t._airbyte_emitted_at
FROM {{ source('cta', '_airbyte_raw_workers') }} as t,
  UNNEST(JSON_EXTRACT_ARRAY(_airbyte_data, '$.businessCommunication.faxes')) AS business_faxes
where 1 = 1