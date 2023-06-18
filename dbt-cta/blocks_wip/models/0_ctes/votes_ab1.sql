{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_votes') }}
select
    {{ json_extract_scalar('_airbyte_data', ['metric_id'], ['metric_id']) }} as metric_id,
    {{ json_extract_scalar('_airbyte_data', ['vote_weight'], ['vote_weight']) }} as vote_weight,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['vote_flag'], ['vote_flag']) }} as vote_flag,
    {{ json_extract_scalar('_airbyte_data', ['report_id'], ['report_id']) }} as report_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['vote_scope'], ['vote_scope']) }} as vote_scope,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_votes') }} as table_alias
-- votes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

