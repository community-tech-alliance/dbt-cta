{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('email_tests_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(hours as {{ dbt_utils.type_float() }}) as hours,
    cast({{ adapter.quote('limit') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('limit') }},
    cast(params as {{ dbt_utils.type_string() }}) as params,
    cast(auto_win as {{ dbt_utils.type_bigint() }}) as auto_win,
    cast(email_id as {{ dbt_utils.type_bigint() }}) as email_id,
    cast(statistic as {{ dbt_utils.type_string() }}) as statistic,
    cast(threshold as {{ dbt_utils.type_float() }}) as threshold,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(winning_email_id as {{ dbt_utils.type_bigint() }}) as winning_email_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('email_tests_ab1') }}
-- email_tests
where 1 = 1

