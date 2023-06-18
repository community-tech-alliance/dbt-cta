{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('phone_banking_phone_banks_ab1') }}
select
    cast(end_date as {{ dbt_utils.type_string() }}) as end_date,
    cast(daily_end_time as {{ dbt_utils.type_string() }}) as daily_end_time,
    cast(min_call_delay_in_hours as {{ dbt_utils.type_bigint() }}) as min_call_delay_in_hours,
    cast(list_id as {{ dbt_utils.type_bigint() }}) as list_id,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(script_id as {{ dbt_utils.type_bigint() }}) as script_id,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    {{ cast_to_boolean('archived') }} as archived,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    {{ cast_to_boolean('closed') }} as closed,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(current_round as {{ dbt_utils.type_bigint() }}) as current_round,
    cast(call_type as {{ dbt_utils.type_string() }}) as call_type,
    cast(daily_start_time as {{ dbt_utils.type_string() }}) as daily_start_time,
    cast(number_of_rounds as {{ dbt_utils.type_bigint() }}) as number_of_rounds,
    cast(start_date as {{ dbt_utils.type_string() }}) as start_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('phone_banking_phone_banks_ab1') }}
-- phone_banking_phone_banks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}