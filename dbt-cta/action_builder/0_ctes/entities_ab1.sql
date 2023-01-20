{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_entities') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['age'], ['age']) }} as age,
    {{ json_extract_scalar('_airbyte_data', ['dw_id'], ['dw_id']) }} as dw_id,
    {{ json_extract_scalar('_airbyte_data', ['nickname'], ['nickname']) }} as nickname,
    {{ json_extract_scalar('_airbyte_data', ['custom_id'], ['custom_id']) }} as custom_id,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['custom_id_1'], ['custom_id_1']) }} as custom_id_1,
    {{ json_extract_scalar('_airbyte_data', ['custom_id_2'], ['custom_id_2']) }} as custom_id_2,
    {{ json_extract_scalar('_airbyte_data', ['custom_id_3'], ['custom_id_3']) }} as custom_id_3,
    {{ json_extract_scalar('_airbyte_data', ['custom_id_4'], ['custom_id_4']) }} as custom_id_4,
    {{ json_extract_scalar('_airbyte_data', ['interact_id'], ['interact_id']) }} as interact_id,
    {{ json_extract_scalar('_airbyte_data', ['middle_name'], ['middle_name']) }} as middle_name,
    {{ json_extract_scalar('_airbyte_data', ['voterbase_id'], ['voterbase_id']) }} as voterbase_id,
    {{ json_extract_scalar('_airbyte_data', ['created_by_id'], ['created_by_id']) }} as created_by_id,
    {{ json_extract_scalar('_airbyte_data', ['date_of_birth'], ['date_of_birth']) }} as date_of_birth,
    {{ json_extract_scalar('_airbyte_data', ['updated_by_id'], ['updated_by_id']) }} as updated_by_id,
    {{ json_extract_scalar('_airbyte_data', ['entity_type_id'], ['entity_type_id']) }} as entity_type_id,
    {{ json_extract_scalar('_airbyte_data', ['linked_user_id'], ['linked_user_id']) }} as linked_user_id,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['preferred_language'], ['preferred_language']) }} as preferred_language,
    {{ json_extract_scalar('_airbyte_data', ['calculated_birth_date'], ['calculated_birth_date']) }} as calculated_birth_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_entities') }} as table_alias
-- entities
where 1 = 1

