{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pg_stat_kcache_ab3') }}
select
    datname,
    exec_reads,
    plan_reads,
    exec_nswaps,
    exec_nvcsws,
    exec_writes,
    plan_nswaps,
    plan_nvcsws,
    plan_writes,
    exec_majflts,
    exec_minflts,
    exec_msgrcvs,
    exec_msgsnds,
    exec_nivcsws,
    plan_majflts,
    plan_minflts,
    plan_msgrcvs,
    plan_msgsnds,
    plan_nivcsws,
    exec_nsignals,
    plan_nsignals,
    exec_user_time,
    plan_user_time,
    exec_reads_blks,
    plan_reads_blks,
    exec_system_time,
    exec_writes_blks,
    plan_system_time,
    plan_writes_blks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_pg_stat_kcache_hashid
from {{ ref('pg_stat_kcache_ab3') }}
-- pg_stat_kcache from {{ source('public', '_airbyte_raw_pg_stat_kcache') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

