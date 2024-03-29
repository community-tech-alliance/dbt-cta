{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_group_growth_by_source_codes') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_group_growth_by_source_codes') }}
-- group_growth_by_source_codes
where 1 = 1
