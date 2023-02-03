{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('subscriptions_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(amount as {{ dbt_utils.type_float() }}) as amount,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(new_user as {{ dbt_utils.type_bigint() }}) as new_user,
    cast(processed as {{ dbt_utils.type_bigint() }}) as processed,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(salesforce as {{ dbt_utils.type_bigint() }}) as salesforce,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(source_code as {{ dbt_utils.type_string() }}) as source_code,
    cast(http_referer as {{ dbt_utils.type_string() }}) as http_referer,
    cast(custom_fields as {{ dbt_utils.type_string() }}) as custom_fields,
    cast(salesforce_id as {{ dbt_utils.type_string() }}) as salesforce_id,
    cast(subscriber_id as {{ dbt_utils.type_bigint() }}) as subscriber_id,
    cast(user_action_id as {{ dbt_utils.type_bigint() }}) as user_action_id,
    cast(network_group_id as {{ dbt_utils.type_bigint() }}) as network_group_id,
    cast(source_action_id as {{ dbt_utils.type_bigint() }}) as source_action_id,
    cast(source_action_type as {{ dbt_utils.type_string() }}) as source_action_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('subscriptions_ab1') }}
-- subscriptions
where 1 = 1

