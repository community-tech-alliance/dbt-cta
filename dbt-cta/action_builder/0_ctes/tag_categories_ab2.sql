{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tag_categories_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    {{ cast_to_boolean('locked') }} as locked,
    cast(target_id as {{ dbt_utils.type_bigint() }}) as target_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(created_by as {{ dbt_utils.type_bigint() }}) as created_by,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(target_type as {{ dbt_utils.type_string() }}) as target_type,
    cast(tag_group_id as {{ dbt_utils.type_bigint() }}) as tag_group_id,
    {{ cast_to_boolean('multiselectable') }} as multiselectable,
    {{ cast_to_boolean('read_only_category') }} as read_only_category,
    cast(allow_create_tag_type as {{ dbt_utils.type_string() }}) as allow_create_tag_type,
    cast(multiselect_same_tag_behavior as {{ dbt_utils.type_bigint() }}) as multiselect_same_tag_behavior,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tag_categories_ab1') }}
-- tag_categories
where 1 = 1

