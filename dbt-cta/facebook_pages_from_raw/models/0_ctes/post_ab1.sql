{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
) }}

{% set raw_source_name = var('cta_dataset_id') + "_raw__stream_page" %}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', raw_source_name) }}
select
    {{ json_extract('table_alias', '_airbyte_data', ['sharedposts'], ['sharedposts']) }} as sharedposts,
    {{ json_extract_scalar('_airbyte_data', ['created_time'], ['created_time']) }} as created_time,
    {{ json_extract('table_alias', '_airbyte_data', ['sponsor_tags'], ['sponsor_tags']) }} as sponsor_tags,
    {{ json_extract('table_alias', '_airbyte_data', ['comments'], ['comments']) }} as comments,
    {{ json_extract_array('_airbyte_data', ['message_tags'], ['message_tags']) }} as message_tags,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract('table_alias', '_airbyte_data', ['reactions'], ['reactions']) }} as reactions,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract('table_alias', '_airbyte_data', ['to'], ['to']) }} as {{ adapter.quote('to') }},
    {{ json_extract_scalar('_airbyte_data', ['message'], ['message']) }} as message,
    {{ json_extract_scalar('_airbyte_data', ['permalink_url'], ['permalink_url']) }} as permalink_url,
    {{ json_extract_array('_airbyte_data', ['actions'], ['actions']) }} as actions,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', raw_source_name) }} as table_alias
-- post
where 1 = 1

