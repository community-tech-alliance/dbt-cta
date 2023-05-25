{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('mobile_message_stats_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(stats as {{ dbt_utils.type_string() }}) as stats,
    cast(header as {{ dbt_utils.type_string() }}) as header,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(actions_count as {{ dbt_utils.type_bigint() }}) as actions_count,
    cast(mobile_message_id as {{ dbt_utils.type_bigint() }}) as mobile_message_id,
    cast(mobile_message_field_id as {{ dbt_utils.type_bigint() }}) as mobile_message_field_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('mobile_message_stats_ab1') }}
-- mobile_message_stats
where 1 = 1

