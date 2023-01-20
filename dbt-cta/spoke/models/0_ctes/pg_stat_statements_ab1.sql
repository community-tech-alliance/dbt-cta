{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_pg_stat_statements') }}
select
    {{ json_extract_scalar('_airbyte_data', ['dbid'], ['dbid']) }} as dbid,
    {{ json_extract_scalar('_airbyte_data', ['rows'], ['rows']) }} as {{ adapter.quote('rows') }},
    {{ json_extract_scalar('_airbyte_data', ['calls'], ['calls']) }} as calls,
    {{ json_extract_scalar('_airbyte_data', ['plans'], ['plans']) }} as plans,
    {{ json_extract_scalar('_airbyte_data', ['query'], ['query']) }} as query,
    {{ json_extract_scalar('_airbyte_data', ['userid'], ['userid']) }} as userid,
    {{ json_extract_scalar('_airbyte_data', ['queryid'], ['queryid']) }} as queryid,
    {{ json_extract_scalar('_airbyte_data', ['wal_fpi'], ['wal_fpi']) }} as wal_fpi,
    {{ json_extract_scalar('_airbyte_data', ['toplevel'], ['toplevel']) }} as toplevel,
    {{ json_extract_scalar('_airbyte_data', ['wal_bytes'], ['wal_bytes']) }} as wal_bytes,
    {{ json_extract_scalar('_airbyte_data', ['wal_records'], ['wal_records']) }} as wal_records,
    {{ json_extract_scalar('_airbyte_data', ['blk_read_time'], ['blk_read_time']) }} as blk_read_time,
    {{ json_extract_scalar('_airbyte_data', ['max_exec_time'], ['max_exec_time']) }} as max_exec_time,
    {{ json_extract_scalar('_airbyte_data', ['max_plan_time'], ['max_plan_time']) }} as max_plan_time,
    {{ json_extract_scalar('_airbyte_data', ['min_exec_time'], ['min_exec_time']) }} as min_exec_time,
    {{ json_extract_scalar('_airbyte_data', ['min_plan_time'], ['min_plan_time']) }} as min_plan_time,
    {{ json_extract_scalar('_airbyte_data', ['blk_write_time'], ['blk_write_time']) }} as blk_write_time,
    {{ json_extract_scalar('_airbyte_data', ['local_blks_hit'], ['local_blks_hit']) }} as local_blks_hit,
    {{ json_extract_scalar('_airbyte_data', ['mean_exec_time'], ['mean_exec_time']) }} as mean_exec_time,
    {{ json_extract_scalar('_airbyte_data', ['mean_plan_time'], ['mean_plan_time']) }} as mean_plan_time,
    {{ json_extract_scalar('_airbyte_data', ['temp_blks_read'], ['temp_blks_read']) }} as temp_blks_read,
    {{ json_extract_scalar('_airbyte_data', ['local_blks_read'], ['local_blks_read']) }} as local_blks_read,
    {{ json_extract_scalar('_airbyte_data', ['shared_blks_hit'], ['shared_blks_hit']) }} as shared_blks_hit,
    {{ json_extract_scalar('_airbyte_data', ['total_exec_time'], ['total_exec_time']) }} as total_exec_time,
    {{ json_extract_scalar('_airbyte_data', ['total_plan_time'], ['total_plan_time']) }} as total_plan_time,
    {{ json_extract_scalar('_airbyte_data', ['shared_blks_read'], ['shared_blks_read']) }} as shared_blks_read,
    {{ json_extract_scalar('_airbyte_data', ['stddev_exec_time'], ['stddev_exec_time']) }} as stddev_exec_time,
    {{ json_extract_scalar('_airbyte_data', ['stddev_plan_time'], ['stddev_plan_time']) }} as stddev_plan_time,
    {{ json_extract_scalar('_airbyte_data', ['temp_blks_written'], ['temp_blks_written']) }} as temp_blks_written,
    {{ json_extract_scalar('_airbyte_data', ['local_blks_dirtied'], ['local_blks_dirtied']) }} as local_blks_dirtied,
    {{ json_extract_scalar('_airbyte_data', ['local_blks_written'], ['local_blks_written']) }} as local_blks_written,
    {{ json_extract_scalar('_airbyte_data', ['shared_blks_dirtied'], ['shared_blks_dirtied']) }} as shared_blks_dirtied,
    {{ json_extract_scalar('_airbyte_data', ['shared_blks_written'], ['shared_blks_written']) }} as shared_blks_written,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_pg_stat_statements') }} as table_alias
-- pg_stat_statements
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

