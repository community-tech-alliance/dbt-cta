{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_letter_templates') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['tips'], ['tips']) }} as tips,
    {{ json_extract_scalar('_airbyte_data', ['message'], ['message']) }} as message,
    {{ json_extract_scalar('_airbyte_data', ['subject'], ['subject']) }} as subject,
    {{ json_extract_scalar('_airbyte_data', ['targets'], ['targets']) }} as targets,
    {{ json_extract_scalar('_airbyte_data', ['can_edit'], ['can_edit']) }} as can_edit,
    {{ json_extract_scalar('_airbyte_data', ['editable'], ['editable']) }} as editable,
    {{ json_extract_scalar('_airbyte_data', ['variants'], ['variants']) }} as variants,
    {{ json_extract_scalar('_airbyte_data', ['letter_id'], ['letter_id']) }} as letter_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['image_attribution'], ['image_attribution']) }} as image_attribution,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_letter_templates') }} as table_alias
-- letter_templates
where 1 = 1

