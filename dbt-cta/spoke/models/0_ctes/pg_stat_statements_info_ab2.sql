{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pg_stat_statements_info_ab1') }}
select
    cast(dealloc as {{ dbt_utils.type_bigint() }}) as dealloc,
    cast({{ empty_string_to_null('stats_reset') }} as {{ type_timestamp_with_timezone() }}) as stats_reset,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pg_stat_statements_info_ab1') }}
-- pg_stat_statements_info
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

