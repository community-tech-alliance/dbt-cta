{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pg_stat_statements_info_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'dealloc',
        'stats_reset',
    ]) }} as _airbyte_pg_stat_statements_info_hashid,
    tmp.*
from {{ ref('pg_stat_statements_info_ab2') }} tmp
-- pg_stat_statements_info
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

