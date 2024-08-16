{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_reports_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['user_email'], ['user_email']) }} as user_email,
    {{ json_extract_scalar('_airbyte_data', ['reportable_id'], ['reportable_id']) }} as reportable_id,
    {{ json_extract_scalar('_airbyte_data', ['reportable_voterbase_id'], ['reportable_voterbase_id']) }} as reportable_voterbase_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['reportable_van_id'], ['reportable_van_id']) }} as reportable_van_id,
    {{ json_extract_scalar('_airbyte_data', ['user_fullname'], ['user_fullname']) }} as user_fullname,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['reportable_type'], ['reportable_type']) }} as reportable_type,
    {{ json_extract_scalar('_airbyte_data', ['reportable_phone'], ['reportable_phone']) }} as reportable_phone,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['activity_id'], ['activity_id']) }} as activity_id,
    {{ json_extract_scalar('_airbyte_data', ['reportable_email'], ['reportable_email']) }} as reportable_email,
    {{ json_extract_scalar('_airbyte_data', ['taggings'], ['taggings']) }} as taggings,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['customizations'], ['customizations']) }} as customizations,
    {{ json_extract_scalar('_airbyte_data', ['reportable_fullname'], ['reportable_fullname']) }} as reportable_fullname,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_reports_export') }} as table_alias
-- reports_export
where 1 = 1

