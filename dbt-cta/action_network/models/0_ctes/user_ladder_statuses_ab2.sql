{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_ladder_statuses_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(rung_id as {{ dbt_utils.type_bigint() }}) as rung_id,
    cast(step_id as {{ dbt_utils.type_bigint() }}) as step_id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(ladder_id as {{ dbt_utils.type_bigint() }}) as ladder_id,
    cast(wait_time as {{ dbt_utils.type_string() }}) as wait_time,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(extra_data as {{ dbt_utils.type_string() }}) as extra_data,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_ladder_statuses_ab1') }}
-- user_ladder_statuses
where 1 = 1
