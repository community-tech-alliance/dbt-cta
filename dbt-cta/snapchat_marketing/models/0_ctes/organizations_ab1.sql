{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_organizations" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_array('_airbyte_data', ['roles'], ['roles']) }} as roles,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['locality'], ['locality']) }} as locality,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['postal_code'], ['postal_code']) }} as postal_code,
    {{ json_extract_scalar('_airbyte_data', ['contact_name'], ['contact_name']) }} as contact_name,
    {{ json_extract_scalar('_airbyte_data', ['my_member_id'], ['my_member_id']) }} as my_member_id,
    {{ json_extract_scalar('_airbyte_data', ['contact_email'], ['contact_email']) }} as contact_email,
    {{ json_extract_scalar('_airbyte_data', ['contact_phone'], ['contact_phone']) }} as contact_phone,
    {{ json_extract_scalar('_airbyte_data', ['address_line_1'], ['address_line_1']) }} as address_line_1,
    {{ json_extract_scalar('_airbyte_data', ['createdByCaller'], ['createdByCaller']) }} as createdByCaller,
    {{ json_extract_scalar('_airbyte_data', ['my_display_name'], ['my_display_name']) }} as my_display_name,
    {{ json_extract_scalar('_airbyte_data', ['my_invited_email'], ['my_invited_email']) }} as my_invited_email,
    {{ json_extract_scalar('_airbyte_data', ['contact_phone_optin'], ['contact_phone_optin']) }} as contact_phone_optin,
    {{ json_extract_scalar('_airbyte_data', ['accepted_term_version'], ['accepted_term_version']) }} as accepted_term_version,
    {{ json_extract('table_alias', '_airbyte_data', ['configuration_settings'], ['configuration_settings']) }} as configuration_settings,
    {{ json_extract_scalar('_airbyte_data', ['administrative_district_level_1'], ['administrative_district_level_1']) }} as administrative_district_level_1,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
-- organizations
where 1 = 1
