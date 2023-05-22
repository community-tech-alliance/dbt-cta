{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('webhook_messages_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(error as {{ dbt_utils.type_bigint() }}) as error,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(attempts as {{ dbt_utils.type_bigint() }}) as attempts,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(extra_data as {{ dbt_utils.type_string() }}) as extra_data,
    cast(trigger_id as {{ dbt_utils.type_bigint() }}) as trigger_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(webhook_id as {{ dbt_utils.type_bigint() }}) as webhook_id,
    cast(error_message as {{ dbt_utils.type_string() }}) as error_message,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('webhook_messages_ab1') }}
-- webhook_messages
where 1 = 1

