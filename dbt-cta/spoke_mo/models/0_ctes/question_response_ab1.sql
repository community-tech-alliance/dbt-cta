{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_question_response') }}
select
    {{ json_extract_scalar('_airbyte_data', ['campaign_contact_id'], ['campaign_contact_id']) }} as campaign_contact_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['value'], ['value']) }} as value,
    {{ json_extract_scalar('_airbyte_data', ['interaction_step_id'], ['interaction_step_id']) }} as interaction_step_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_question_response') }} as table_alias
-- question_response
where 1 = 1


