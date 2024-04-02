{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('donation_payments_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(tip as {{ dbt_utils.type_bigint() }}) as tip,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(error as {{ dbt_utils.type_bigint() }}) as error,
    cast(amount as {{ dbt_utils.type_float() }}) as amount,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(wepay_id as {{ dbt_utils.type_bigint() }}) as wepay_id,
    cast(recurring as {{ dbt_utils.type_bigint() }}) as recurring,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(error_code as {{ dbt_utils.type_string() }}) as error_code,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(donation_id as {{ dbt_utils.type_bigint() }}) as donation_id,
    cast(wepay_status as {{ dbt_utils.type_string() }}) as wepay_status,
    cast(error_message as {{ dbt_utils.type_string() }}) as error_message,
    cast(fundraising_id as {{ dbt_utils.type_bigint() }}) as fundraising_id,
    cast(transaction_id as {{ dbt_utils.type_string() }}) as transaction_id,
    cast(donation_user_id as {{ dbt_utils.type_bigint() }}) as donation_user_id,
    cast(recurring_period as {{ dbt_utils.type_string() }}) as recurring_period,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('donation_payments_ab1') }}
-- donation_payments
where 1 = 1
