{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_locations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['event_id'], ['event_id']) }} as event_id,
    {{ json_extract_scalar('_airbyte_data', ['latitude'], ['latitude']) }} as latitude,
    {{ json_extract_scalar('_airbyte_data', ['zip_code'], ['zip_code']) }} as zip_code,
    {{ json_extract_scalar('_airbyte_data', ['longitude'], ['longitude']) }} as longitude,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['location_name'], ['location_name']) }} as location_name,
    {{ json_extract_scalar('_airbyte_data', ['event_campaign_id'], ['event_campaign_id']) }} as event_campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['event_campaign_upload_id'], ['event_campaign_upload_id']) }} as event_campaign_upload_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_locations') }} as table_alias
-- locations
where 1 = 1

