{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pg_stat_statements_ab3') }}
select
    dbid,
    {{ adapter.quote('rows') }},
    calls,
    plans,
    query,
    userid,
    queryid,
    wal_fpi,
    toplevel,
    wal_bytes,
    wal_records,
    blk_read_time,
    max_exec_time,
    max_plan_time,
    min_exec_time,
    min_plan_time,
    blk_write_time,
    local_blks_hit,
    mean_exec_time,
    mean_plan_time,
    temp_blks_read,
    local_blks_read,
    shared_blks_hit,
    total_exec_time,
    total_plan_time,
    shared_blks_read,
    stddev_exec_time,
    stddev_plan_time,
    temp_blks_written,
    local_blks_dirtied,
    local_blks_written,
    shared_blks_dirtied,
    shared_blks_written,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_pg_stat_statements_hashid
from {{ ref('pg_stat_statements_ab3') }}
-- pg_stat_statements from {{ source('public', '_airbyte_raw_pg_stat_statements') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

