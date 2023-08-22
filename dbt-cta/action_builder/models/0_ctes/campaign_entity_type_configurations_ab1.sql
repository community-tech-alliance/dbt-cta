{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_campaign_entity_type_configurations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['entity_type_id'], ['entity_type_id']) }} as entity_type_id,
    {{ json_extract_scalar('_airbyte_data', ['spotlight_icon'], ['spotlight_icon']) }} as spotlight_icon,
    {{ json_extract_scalar('_airbyte_data', ['spotlight_tag_ids'], ['spotlight_tag_ids']) }} as spotlight_tag_ids,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_campaign_entity_type_configurations') }}
-- campaign_entity_type_configurations
where 1 = 1
