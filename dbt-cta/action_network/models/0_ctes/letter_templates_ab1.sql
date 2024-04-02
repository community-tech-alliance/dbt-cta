{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_letter_templates" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- letter_templates
where 1 = 1
