{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pg_stat_statements_ab1') }}
select
    cast(dbid as {{ dbt_utils.type_bigint() }}) as dbid,
    cast({{ adapter.quote('rows') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('rows') }},
    cast(calls as {{ dbt_utils.type_bigint() }}) as calls,
    cast(plans as {{ dbt_utils.type_bigint() }}) as plans,
    cast(query as {{ dbt_utils.type_string() }}) as query,
    cast(userid as {{ dbt_utils.type_bigint() }}) as userid,
    cast(queryid as {{ dbt_utils.type_bigint() }}) as queryid,
    cast(wal_fpi as {{ dbt_utils.type_bigint() }}) as wal_fpi,
    {{ cast_to_boolean('toplevel') }} as toplevel,
    cast(wal_bytes as {{ dbt_utils.type_float() }}) as wal_bytes,
    cast(wal_records as {{ dbt_utils.type_bigint() }}) as wal_records,
    cast(blk_read_time as {{ dbt_utils.type_float() }}) as blk_read_time,
    cast(max_exec_time as {{ dbt_utils.type_float() }}) as max_exec_time,
    cast(max_plan_time as {{ dbt_utils.type_float() }}) as max_plan_time,
    cast(min_exec_time as {{ dbt_utils.type_float() }}) as min_exec_time,
    cast(min_plan_time as {{ dbt_utils.type_float() }}) as min_plan_time,
    cast(blk_write_time as {{ dbt_utils.type_float() }}) as blk_write_time,
    cast(local_blks_hit as {{ dbt_utils.type_bigint() }}) as local_blks_hit,
    cast(mean_exec_time as {{ dbt_utils.type_float() }}) as mean_exec_time,
    cast(mean_plan_time as {{ dbt_utils.type_float() }}) as mean_plan_time,
    cast(temp_blks_read as {{ dbt_utils.type_bigint() }}) as temp_blks_read,
    cast(local_blks_read as {{ dbt_utils.type_bigint() }}) as local_blks_read,
    cast(shared_blks_hit as {{ dbt_utils.type_bigint() }}) as shared_blks_hit,
    cast(total_exec_time as {{ dbt_utils.type_float() }}) as total_exec_time,
    cast(total_plan_time as {{ dbt_utils.type_float() }}) as total_plan_time,
    cast(shared_blks_read as {{ dbt_utils.type_bigint() }}) as shared_blks_read,
    cast(stddev_exec_time as {{ dbt_utils.type_float() }}) as stddev_exec_time,
    cast(stddev_plan_time as {{ dbt_utils.type_float() }}) as stddev_plan_time,
    cast(temp_blks_written as {{ dbt_utils.type_bigint() }}) as temp_blks_written,
    cast(local_blks_dirtied as {{ dbt_utils.type_bigint() }}) as local_blks_dirtied,
    cast(local_blks_written as {{ dbt_utils.type_bigint() }}) as local_blks_written,
    cast(shared_blks_dirtied as {{ dbt_utils.type_bigint() }}) as shared_blks_dirtied,
    cast(shared_blks_written as {{ dbt_utils.type_bigint() }}) as shared_blks_written,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pg_stat_statements_ab1') }}
-- pg_stat_statements
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

