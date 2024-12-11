{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_native_ads" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    json_extract(_airbyte_data, "$['icon']") as icon,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['channel'], ['channel']) }} as channel,
    {{ json_extract_scalar('_airbyte_data', ['cta_text'], ['cta_text']) }} as cta_text,
    {{ json_extract_scalar('_airbyte_data', ['brandname'], ['brandname']) }} as brandname,
    {{ json_extract_scalar('_airbyte_data', ['click_url'], ['click_url']) }} as click_url,
    {{ json_extract_array('_airbyte_data', ['creatives'], ['creatives']) }} as creatives,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    json_extract(_airbyte_data, "$['input_data']") as input_data,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['audit_status'], ['audit_status']) }} as audit_status,
    {{ json_extract_array('_airbyte_data', ['vast_trackers'], ['vast_trackers']) }} as vast_trackers,
    {{ json_extract_array('_airbyte_data', ['api_frameworks'], ['api_frameworks']) }} as api_frameworks,
    {{ json_extract_array('_airbyte_data', ['imp_tracker_urls'], ['imp_tracker_urls']) }} as imp_tracker_urls,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- native_ads
where 1 = 1
