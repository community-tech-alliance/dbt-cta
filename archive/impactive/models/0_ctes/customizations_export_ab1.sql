{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_customizations_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['custom_field_slug'], ['custom_field_slug']) }} as custom_field_slug,
    {{ json_extract_scalar('_airbyte_data', ['custom_field_name'], ['custom_field_name']) }} as custom_field_name,
    {{ json_extract_scalar('_airbyte_data', ['reportable_id'], ['reportable_id']) }} as reportable_id,
    {{ json_extract_scalar('_airbyte_data', ['voterbase_id'], ['voterbase_id']) }} as voterbase_id,
    {{ json_extract_scalar('_airbyte_data', ['customizable_id'], ['customizable_id']) }} as customizable_id,
    {{ json_extract_scalar('_airbyte_data', ['customizable_type'], ['customizable_type']) }} as customizable_type,
    {{ json_extract_scalar('_airbyte_data', ['reported_by_email'], ['reported_by_email']) }} as reported_by_email,
    {{ json_extract_scalar('_airbyte_data', ['custom_field_id'], ['custom_field_id']) }} as custom_field_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['reportable_type'], ['reportable_type']) }} as reportable_type,
    {{ json_extract_scalar('_airbyte_data', ['van_id'], ['van_id']) }} as van_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['fullname'], ['fullname']) }} as fullname,
    {{ json_extract_scalar('_airbyte_data', ['reported_by_fullname'], ['reported_by_fullname']) }} as reported_by_fullname,
    {{ json_extract_scalar('_airbyte_data', ['value'], ['value']) }} as value,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_customizations_export') }} as table_alias
-- customizations_export
where 1 = 1

