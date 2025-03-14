{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_applications" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['application_name'], ['application_name']) }} as application_name,
    {{ json_extract_scalar('_airbyte_data', ['date_format'], ['date_format']) }} as date_format,
    {{ json_extract_scalar('_airbyte_data', ['creation_date'], ['creation_date']) }} as creation_date,
    {{ json_extract_scalar('_airbyte_data', ['category'], ['category']) }} as category,
    {{ json_extract_scalar('_airbyte_data', ['link_name'], ['link_name']) }} as link_name,
    {{ json_extract_scalar('_airbyte_data', ['time_zone'], ['time_zone']) }} as time_zone,
    {{ json_extract_scalar('_airbyte_data', ['created_by'], ['created_by']) }} as created_by,
    {{ json_extract_scalar('_airbyte_data', ['workspace_name'], ['workspace_name']) }} as workspace_name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- applications
where 1 = 1
