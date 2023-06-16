{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_scheduled_exports') }}
select
    {{ json_extract_scalar('_airbyte_data', ['day_of_the_week'], ['day_of_the_week']) }} as day_of_the_week,
    {{ json_extract_scalar('_airbyte_data', ['paused'], ['paused']) }} as paused,
    {{ json_extract_scalar('_airbyte_data', ['columns'], ['columns']) }} as columns,
    {{ json_extract_scalar('_airbyte_data', ['attachment_name'], ['attachment_name']) }} as attachment_name,
    {{ json_extract_scalar('_airbyte_data', ['format'], ['format']) }} as format,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['table_name'], ['table_name']) }} as table_name,
    {{ json_extract_scalar('_airbyte_data', ['frequency'], ['frequency']) }} as frequency,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['time_zone_identifier'], ['time_zone_identifier']) }} as time_zone_identifier,
    {{ json_extract_scalar('_airbyte_data', ['recipients'], ['recipients']) }} as recipients,
    {{ json_extract_scalar('_airbyte_data', ['last_processed_at'], ['last_processed_at']) }} as last_processed_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['hour_of_the_day'], ['hour_of_the_day']) }} as hour_of_the_day,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_scheduled_exports') }} as table_alias
-- scheduled_exports
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

