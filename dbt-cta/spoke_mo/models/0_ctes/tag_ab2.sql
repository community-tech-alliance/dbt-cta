{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tag_ab1') }}
select
    {{ cast_to_boolean('is_deleted') }} as is_deleted,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ adapter.quote('group') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('group') }},
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tag_ab1') }}
-- tag
where 1 = 1


