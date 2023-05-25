{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('triggers_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(step_id as {{ dbt_utils.type_bigint() }}) as step_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(ladder_id as {{ dbt_utils.type_bigint() }}) as ladder_id,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(webhook_id as {{ dbt_utils.type_bigint() }}) as webhook_id,
    cast(action_type as {{ dbt_utils.type_string() }}) as action_type,
    cast(trigger_type as {{ dbt_utils.type_string() }}) as trigger_type,
    cast(exclude_uploads as {{ dbt_utils.type_bigint() }}) as exclude_uploads,
    cast(only_text_to_join as {{ dbt_utils.type_bigint() }}) as only_text_to_join,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('triggers_ab1') }}
-- triggers
where 1 = 1

