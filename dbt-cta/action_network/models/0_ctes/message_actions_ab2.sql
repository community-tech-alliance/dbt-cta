{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('message_actions_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(referrer as {{ dbt_utils.type_string() }}) as referrer,
    cast(action_id as {{ dbt_utils.type_bigint() }}) as action_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(sending_id as {{ dbt_utils.type_bigint() }}) as sending_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(action_type as {{ dbt_utils.type_string() }}) as action_type,
    cast(sending_type as {{ dbt_utils.type_string() }}) as sending_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('message_actions_ab1') }}
-- message_actions
where 1 = 1
