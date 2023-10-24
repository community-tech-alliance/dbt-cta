{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_user_activity_performances_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['performed_at'], ['performed_at']) }} as performed_at,
    {{ json_extract_scalar('_airbyte_data', ['user_email'], ['user_email']) }} as user_email,
    {{ json_extract_scalar('_airbyte_data', ['user_last_name'], ['user_last_name']) }} as user_last_name,
    {{ json_extract_scalar('_airbyte_data', ['user_fullname'], ['user_fullname']) }} as user_fullname,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['user_first_name'], ['user_first_name']) }} as user_first_name,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['activity_id'], ['activity_id']) }} as activity_id,
    {{ json_extract_scalar('_airbyte_data', ['user_phone'], ['user_phone']) }} as user_phone,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['activity_title'], ['activity_title']) }} as activity_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_user_activity_performances_export') }} as table_alias
-- user_activity_performances_export
where 1 = 1

