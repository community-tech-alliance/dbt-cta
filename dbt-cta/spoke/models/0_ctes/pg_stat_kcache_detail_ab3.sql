{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pg_stat_kcache_detail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('top'),
        'query',
        'datname',
        'rolname',
        'exec_reads',
        'plan_reads',
        'exec_nswaps',
        'exec_nvcsws',
        'exec_writes',
        'plan_nswaps',
        'plan_nvcsws',
        'plan_writes',
        'exec_majflts',
        'exec_minflts',
        'exec_msgrcvs',
        'exec_msgsnds',
        'exec_nivcsws',
        'plan_majflts',
        'plan_minflts',
        'plan_msgrcvs',
        'plan_msgsnds',
        'plan_nivcsws',
        'exec_nsignals',
        'plan_nsignals',
        'exec_user_time',
        'plan_user_time',
        'exec_reads_blks',
        'plan_reads_blks',
        'exec_system_time',
        'exec_writes_blks',
        'plan_system_time',
        'plan_writes_blks',
    ]) }} as _airbyte_pg_stat_kcache_detail_hashid,
    tmp.*
from {{ ref('pg_stat_kcache_detail_ab2') }} tmp
-- pg_stat_kcache_detail
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

