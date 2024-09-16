{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_campaign" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['override_organization_texting_hours'], ['override_organization_texting_hours']) }} as override_organization_texting_hours,
    {{ json_extract_scalar('_airbyte_data', ['batch_size'], ['batch_size']) }} as batch_size,
    {{ json_extract_scalar('_airbyte_data', ['texting_hours_start'], ['texting_hours_start']) }} as texting_hours_start,
    {{ json_extract_scalar('_airbyte_data', ['logo_image_url'], ['logo_image_url']) }} as logo_image_url,
    {{ json_extract_scalar('_airbyte_data', ['due_by'], ['due_by']) }} as due_by,
    {{ json_extract_scalar('_airbyte_data', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['texting_hours_end'], ['texting_hours_end']) }} as texting_hours_end,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['primary_color'], ['primary_color']) }} as primary_color,
    {{ json_extract_scalar('_airbyte_data', ['use_dynamic_assignment'], ['use_dynamic_assignment']) }} as use_dynamic_assignment,
    {{ json_extract_scalar('_airbyte_data', ['use_own_messaging_service'], ['use_own_messaging_service']) }} as use_own_messaging_service,
    {{ json_extract_scalar('_airbyte_data', ['features'], ['features']) }} as features,
    {{ json_extract_scalar('_airbyte_data', ['is_started'], ['is_started']) }} as is_started,
    {{ json_extract_scalar('_airbyte_data', ['join_token'], ['join_token']) }} as join_token,
    {{ json_extract_scalar('_airbyte_data', ['is_archived'], ['is_archived']) }} as is_archived,
    {{ json_extract_scalar('_airbyte_data', ['intro_html'], ['intro_html']) }} as intro_html,
    {{ json_extract_scalar('_airbyte_data', ['texting_hours_enforced'], ['texting_hours_enforced']) }} as texting_hours_enforced,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['creator_id'], ['creator_id']) }} as creator_id,
    {{ json_extract_scalar('_airbyte_data', ['messageservice_sid'], ['messageservice_sid']) }} as messageservice_sid,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['response_window'], ['response_window']) }} as response_window,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- campaign
where 1 = 1
