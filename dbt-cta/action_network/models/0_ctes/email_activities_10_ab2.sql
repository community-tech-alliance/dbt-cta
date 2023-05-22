{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('email_activities_10_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(link_id as {{ dbt_utils.type_bigint() }}) as link_id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(email_id as {{ dbt_utils.type_bigint() }}) as email_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(subject_id as {{ dbt_utils.type_bigint() }}) as subject_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(action_type as {{ dbt_utils.type_string() }}) as action_type,
    cast(recipient_id as {{ dbt_utils.type_bigint() }}) as recipient_id,
    cast(email_stat_id as {{ dbt_utils.type_bigint() }}) as email_stat_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('email_activities_10_ab1') }}
-- email_activities_10
where 1 = 1

