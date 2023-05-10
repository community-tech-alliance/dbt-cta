{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('action_fields_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(position as {{ dbt_utils.type_bigint() }}) as position,
    cast(action_id as {{ dbt_utils.type_bigint() }}) as action_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    {{ cast_to_boolean('is_optional') }} as is_optional,
    cast(object_type as {{ dbt_utils.type_string() }}) as object_type,
    cast(object_attribute as {{ dbt_utils.type_string() }}) as object_attribute,
    cast(related_object_id as {{ dbt_utils.type_bigint() }}) as related_object_id,
    cast(default_response_id as {{ dbt_utils.type_bigint() }}) as default_response_id,
    cast(related_object_type as {{ dbt_utils.type_string() }}) as related_object_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('action_fields_ab1') }}
-- action_fields
where 1 = 1

