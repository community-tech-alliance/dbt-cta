{% set raw_table = env_var("CTA_DATASET_ID") ~ "_airbyte_raw_subscriptions_1" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', 'raw_table') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['new_user'], ['new_user']) }} as new_user,
    {{ json_extract_scalar('_airbyte_data', ['processed'], ['processed']) }} as processed,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['salesforce'], ['salesforce']) }} as salesforce,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['source_code'], ['source_code']) }} as source_code,
    {{ json_extract_scalar('_airbyte_data', ['http_referer'], ['http_referer']) }} as http_referer,
    {{ json_extract_scalar('_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_id'], ['salesforce_id']) }} as salesforce_id,
    {{ json_extract_scalar('_airbyte_data', ['subscriber_id'], ['subscriber_id']) }} as subscriber_id,
    {{ json_extract_scalar('_airbyte_data', ['user_action_id'], ['user_action_id']) }} as user_action_id,
    {{ json_extract_scalar('_airbyte_data', ['network_group_id'], ['network_group_id']) }} as network_group_id,
    {{ json_extract_scalar('_airbyte_data', ['source_action_id'], ['source_action_id']) }} as source_action_id,
    {{ json_extract_scalar('_airbyte_data', ['source_action_type'], ['source_action_type']) }} as source_action_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', 'raw_table') }}
-- subscriptions_1
where 1 = 1
