{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_group_growth_by_source_codes" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['end_at'], ['end_at']) }} as end_at,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['start_at'], ['start_at']) }} as start_at,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['source_code'], ['source_code']) }} as source_code,
    {{ json_extract_scalar('_airbyte_data', ['total_count'], ['total_count']) }} as total_count,
    {{ json_extract_scalar('_airbyte_data', ['new_users_count'], ['new_users_count']) }} as new_users_count,
    {{ json_extract_scalar('_airbyte_data', ['last_subscription_id'], ['last_subscription_id']) }} as last_subscription_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
where 1 = 1
