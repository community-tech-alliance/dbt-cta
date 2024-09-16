{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('actions_ab1') }}
select
    cast(actionable_type as {{ dbt_utils.type_string() }}) as actionable_type,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(actionable_id as {{ dbt_utils.type_bigint() }}) as actionable_id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('actions_ab1') }}
-- actions
