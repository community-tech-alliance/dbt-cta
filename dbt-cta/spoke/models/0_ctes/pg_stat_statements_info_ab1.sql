{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_pg_stat_statements_info') }}
select
    {{ json_extract_scalar('_airbyte_data', ['dealloc'], ['dealloc']) }} as dealloc,
    {{ json_extract_scalar('_airbyte_data', ['stats_reset'], ['stats_reset']) }} as stats_reset,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_pg_stat_statements_info') }} as table_alias
-- pg_stat_statements_info
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

