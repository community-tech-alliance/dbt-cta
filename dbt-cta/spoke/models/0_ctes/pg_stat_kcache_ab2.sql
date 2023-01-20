{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pg_stat_kcache_ab1') }}
select
    cast(datname as {{ dbt_utils.type_string() }}) as datname,
    cast(exec_reads as {{ dbt_utils.type_float() }}) as exec_reads,
    cast(plan_reads as {{ dbt_utils.type_float() }}) as plan_reads,
    cast(exec_nswaps as {{ dbt_utils.type_float() }}) as exec_nswaps,
    cast(exec_nvcsws as {{ dbt_utils.type_float() }}) as exec_nvcsws,
    cast(exec_writes as {{ dbt_utils.type_float() }}) as exec_writes,
    cast(plan_nswaps as {{ dbt_utils.type_float() }}) as plan_nswaps,
    cast(plan_nvcsws as {{ dbt_utils.type_float() }}) as plan_nvcsws,
    cast(plan_writes as {{ dbt_utils.type_float() }}) as plan_writes,
    cast(exec_majflts as {{ dbt_utils.type_float() }}) as exec_majflts,
    cast(exec_minflts as {{ dbt_utils.type_float() }}) as exec_minflts,
    cast(exec_msgrcvs as {{ dbt_utils.type_float() }}) as exec_msgrcvs,
    cast(exec_msgsnds as {{ dbt_utils.type_float() }}) as exec_msgsnds,
    cast(exec_nivcsws as {{ dbt_utils.type_float() }}) as exec_nivcsws,
    cast(plan_majflts as {{ dbt_utils.type_float() }}) as plan_majflts,
    cast(plan_minflts as {{ dbt_utils.type_float() }}) as plan_minflts,
    cast(plan_msgrcvs as {{ dbt_utils.type_float() }}) as plan_msgrcvs,
    cast(plan_msgsnds as {{ dbt_utils.type_float() }}) as plan_msgsnds,
    cast(plan_nivcsws as {{ dbt_utils.type_float() }}) as plan_nivcsws,
    cast(exec_nsignals as {{ dbt_utils.type_float() }}) as exec_nsignals,
    cast(plan_nsignals as {{ dbt_utils.type_float() }}) as plan_nsignals,
    cast(exec_user_time as {{ dbt_utils.type_float() }}) as exec_user_time,
    cast(plan_user_time as {{ dbt_utils.type_float() }}) as plan_user_time,
    cast(exec_reads_blks as {{ dbt_utils.type_float() }}) as exec_reads_blks,
    cast(plan_reads_blks as {{ dbt_utils.type_float() }}) as plan_reads_blks,
    cast(exec_system_time as {{ dbt_utils.type_float() }}) as exec_system_time,
    cast(exec_writes_blks as {{ dbt_utils.type_float() }}) as exec_writes_blks,
    cast(plan_system_time as {{ dbt_utils.type_float() }}) as plan_system_time,
    cast(plan_writes_blks as {{ dbt_utils.type_float() }}) as plan_writes_blks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pg_stat_kcache_ab1') }}
-- pg_stat_kcache
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

