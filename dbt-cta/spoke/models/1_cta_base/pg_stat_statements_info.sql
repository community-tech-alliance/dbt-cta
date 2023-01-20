{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('pg_stat_statements_info_ab3') }}
select
    dealloc,
    stats_reset,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_pg_stat_statements_info_hashid
from {{ ref('pg_stat_statements_info_ab3') }}
-- pg_stat_statements_info from {{ source('public', '_airbyte_raw_pg_stat_statements_info') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

