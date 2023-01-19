{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('actions_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(text as {{ dbt_utils.type_string() }}) as text,
    {{ cast_to_boolean('active') }} as active,
    cast({{ empty_string_to_null('due_date') }} as {{ type_date() }}) as due_date,
    {{ cast_to_boolean('completed') }} as completed,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast(entity_type_id as {{ dbt_utils.type_bigint() }}) as entity_type_id,
    {{ cast_to_boolean('quick_check_in') }} as quick_check_in,
    cast(canvassing_type as {{ dbt_utils.type_bigint() }}) as canvassing_type,
    {{ cast_to_boolean('canvassing_enabled') }} as canvassing_enabled,
    cast(targets_query_json as {{ dbt_utils.type_string() }}) as targets_query_json,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('actions_ab1') }}
-- actions
where 1 = 1

