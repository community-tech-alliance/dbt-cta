{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sms_status_logs_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(new_user as {{ dbt_utils.type_bigint() }}) as new_user,
    cast(processed as {{ dbt_utils.type_bigint() }}) as processed,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(sms_opt_in as {{ dbt_utils.type_bigint() }}) as sms_opt_in,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(subscriber_id as {{ dbt_utils.type_bigint() }}) as subscriber_id,
    cast(subscription_id as {{ dbt_utils.type_bigint() }}) as subscription_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sms_status_logs_ab1') }}
-- sms_status_logs
where 1 = 1

