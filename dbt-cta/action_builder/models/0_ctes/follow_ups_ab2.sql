{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('follow_ups_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(entity_id as {{ dbt_utils.type_bigint() }}) as entity_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast({{ empty_string_to_null('completed_at') }} as {{ type_timestamp_without_timezone() }}) as completed_at,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast(completed_by_id as {{ dbt_utils.type_bigint() }}) as completed_by_id,
    cast(assigned_user_id as {{ dbt_utils.type_bigint() }}) as assigned_user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('follow_ups_ab1') }}
-- follow_ups
where 1 = 1

