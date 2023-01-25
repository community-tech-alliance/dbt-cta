{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('recurring_donations_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(values as {{ dbt_utils.type_string() }}) as values,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(next_payment as {{ dbt_utils.type_string() }}) as next_payment,
    cast(failure_count as {{ dbt_utils.type_bigint() }}) as failure_count,
    cast(fundraising_id as {{ dbt_utils.type_bigint() }}) as fundraising_id,
    cast(recurring_period as {{ dbt_utils.type_string() }}) as recurring_period,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('recurring_donations_ab1') }}
-- recurring_donations
where 1 = 1

