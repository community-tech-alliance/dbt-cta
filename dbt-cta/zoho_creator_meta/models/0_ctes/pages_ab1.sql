{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_pages" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['application_link_name'], ['application_link_name']) }} as application_link_name,
    {{ json_extract_scalar('_airbyte_data', ['link_name'], ['link_name']) }} as link_name,
    {{ json_extract_scalar('_airbyte_data', ['display_name'], ['display_name']) }} as display_name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- pages
where 1 = 1
