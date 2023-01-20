{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_pg_stat_kcache') }}
select
    {{ json_extract_scalar('_airbyte_data', ['datname'], ['datname']) }} as datname,
    {{ json_extract_scalar('_airbyte_data', ['exec_reads'], ['exec_reads']) }} as exec_reads,
    {{ json_extract_scalar('_airbyte_data', ['plan_reads'], ['plan_reads']) }} as plan_reads,
    {{ json_extract_scalar('_airbyte_data', ['exec_nswaps'], ['exec_nswaps']) }} as exec_nswaps,
    {{ json_extract_scalar('_airbyte_data', ['exec_nvcsws'], ['exec_nvcsws']) }} as exec_nvcsws,
    {{ json_extract_scalar('_airbyte_data', ['exec_writes'], ['exec_writes']) }} as exec_writes,
    {{ json_extract_scalar('_airbyte_data', ['plan_nswaps'], ['plan_nswaps']) }} as plan_nswaps,
    {{ json_extract_scalar('_airbyte_data', ['plan_nvcsws'], ['plan_nvcsws']) }} as plan_nvcsws,
    {{ json_extract_scalar('_airbyte_data', ['plan_writes'], ['plan_writes']) }} as plan_writes,
    {{ json_extract_scalar('_airbyte_data', ['exec_majflts'], ['exec_majflts']) }} as exec_majflts,
    {{ json_extract_scalar('_airbyte_data', ['exec_minflts'], ['exec_minflts']) }} as exec_minflts,
    {{ json_extract_scalar('_airbyte_data', ['exec_msgrcvs'], ['exec_msgrcvs']) }} as exec_msgrcvs,
    {{ json_extract_scalar('_airbyte_data', ['exec_msgsnds'], ['exec_msgsnds']) }} as exec_msgsnds,
    {{ json_extract_scalar('_airbyte_data', ['exec_nivcsws'], ['exec_nivcsws']) }} as exec_nivcsws,
    {{ json_extract_scalar('_airbyte_data', ['plan_majflts'], ['plan_majflts']) }} as plan_majflts,
    {{ json_extract_scalar('_airbyte_data', ['plan_minflts'], ['plan_minflts']) }} as plan_minflts,
    {{ json_extract_scalar('_airbyte_data', ['plan_msgrcvs'], ['plan_msgrcvs']) }} as plan_msgrcvs,
    {{ json_extract_scalar('_airbyte_data', ['plan_msgsnds'], ['plan_msgsnds']) }} as plan_msgsnds,
    {{ json_extract_scalar('_airbyte_data', ['plan_nivcsws'], ['plan_nivcsws']) }} as plan_nivcsws,
    {{ json_extract_scalar('_airbyte_data', ['exec_nsignals'], ['exec_nsignals']) }} as exec_nsignals,
    {{ json_extract_scalar('_airbyte_data', ['plan_nsignals'], ['plan_nsignals']) }} as plan_nsignals,
    {{ json_extract_scalar('_airbyte_data', ['exec_user_time'], ['exec_user_time']) }} as exec_user_time,
    {{ json_extract_scalar('_airbyte_data', ['plan_user_time'], ['plan_user_time']) }} as plan_user_time,
    {{ json_extract_scalar('_airbyte_data', ['exec_reads_blks'], ['exec_reads_blks']) }} as exec_reads_blks,
    {{ json_extract_scalar('_airbyte_data', ['plan_reads_blks'], ['plan_reads_blks']) }} as plan_reads_blks,
    {{ json_extract_scalar('_airbyte_data', ['exec_system_time'], ['exec_system_time']) }} as exec_system_time,
    {{ json_extract_scalar('_airbyte_data', ['exec_writes_blks'], ['exec_writes_blks']) }} as exec_writes_blks,
    {{ json_extract_scalar('_airbyte_data', ['plan_system_time'], ['plan_system_time']) }} as plan_system_time,
    {{ json_extract_scalar('_airbyte_data', ['plan_writes_blks'], ['plan_writes_blks']) }} as plan_writes_blks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_pg_stat_kcache') }} as table_alias
-- pg_stat_kcache
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

