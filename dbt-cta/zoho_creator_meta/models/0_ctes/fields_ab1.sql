{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_fields" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_array('_airbyte_data', ['subfields'], ['subfields']) }} as subfields,
    {{ json_extract_scalar('_airbyte_data', ['unique'], ['unique']) }} as unique,
    {{ json_extract_scalar('_airbyte_data', ['max_char'], ['max_char']) }} as max_char,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_array('_airbyte_data', ['choices'], ['choices']) }} as choices,
    {{ json_extract_scalar('_airbyte_data', ['link_name'], ['link_name']) }} as link_name,
    {{ json_extract_scalar('_airbyte_data', ['display_name'], ['display_name']) }} as display_name,
    {{ json_extract_scalar('_airbyte_data', ['mandatory'], ['mandatory']) }} as mandatory,
    {{ json_extract_scalar('_airbyte_data', ['form_link_name'], ['form_link_name']) }} as form_link_name,
    {{ json_extract_scalar('_airbyte_data', ['application_link_name'], ['application_link_name']) }} as application_link_name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- fields
where 1 = 1
