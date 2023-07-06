{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('votes_ab1') }}
select
    cast(metric_id as {{ dbt_utils.type_bigint() }}) as metric_id,
    cast(vote_weight as {{ dbt_utils.type_bigint() }}) as vote_weight,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    {{ cast_to_boolean('vote_flag') }} as vote_flag,
    cast(report_id as {{ dbt_utils.type_bigint() }}) as report_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(vote_scope as {{ dbt_utils.type_string() }}) as vote_scope,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('votes_ab1') }}
-- votes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

