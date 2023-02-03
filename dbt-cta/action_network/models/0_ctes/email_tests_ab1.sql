{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_email_tests') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['hours'], ['hours']) }} as hours,
    {{ json_extract_scalar('_airbyte_data', ['limit'], ['limit']) }} as {{ adapter.quote('limit') }},
    {{ json_extract_scalar('_airbyte_data', ['params'], ['params']) }} as params,
    {{ json_extract_scalar('_airbyte_data', ['auto_win'], ['auto_win']) }} as auto_win,
    {{ json_extract_scalar('_airbyte_data', ['email_id'], ['email_id']) }} as email_id,
    {{ json_extract_scalar('_airbyte_data', ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar('_airbyte_data', ['threshold'], ['threshold']) }} as threshold,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['winning_email_id'], ['winning_email_id']) }} as winning_email_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_email_tests') }} as table_alias
-- email_tests
where 1 = 1

