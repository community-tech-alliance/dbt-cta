{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pg_stat_statements_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'dbid',
        adapter.quote('rows'),
        'calls',
        'plans',
        'query',
        'userid',
        'queryid',
        'wal_fpi',
        boolean_to_string('toplevel'),
        'wal_bytes',
        'wal_records',
        'blk_read_time',
        'max_exec_time',
        'max_plan_time',
        'min_exec_time',
        'min_plan_time',
        'blk_write_time',
        'local_blks_hit',
        'mean_exec_time',
        'mean_plan_time',
        'temp_blks_read',
        'local_blks_read',
        'shared_blks_hit',
        'total_exec_time',
        'total_plan_time',
        'shared_blks_read',
        'stddev_exec_time',
        'stddev_plan_time',
        'temp_blks_written',
        'local_blks_dirtied',
        'local_blks_written',
        'shared_blks_dirtied',
        'shared_blks_written',
    ]) }} as _airbyte_pg_stat_statements_hashid,
    tmp.*
from {{ ref('pg_stat_statements_ab2') }} tmp
-- pg_stat_statements
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

