{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('versions_ab1') }}
select
    cast(item_id as {{ dbt_utils.type_bigint() }}) as item_id,
    cast(item_type as {{ dbt_utils.type_string() }}) as item_type,
    cast(object_yaml as {{ dbt_utils.type_string() }}) as object_yaml,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(event as {{ dbt_utils.type_string() }}) as event,
    cast(whodunnit as {{ dbt_utils.type_string() }}) as whodunnit,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('versions_ab1') }}
-- versions
where 1 = 1

