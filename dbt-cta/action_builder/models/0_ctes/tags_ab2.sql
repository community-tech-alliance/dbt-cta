{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tags_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(text as {{ dbt_utils.type_string() }}) as text,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(tag_type as {{ dbt_utils.type_string() }}) as tag_type,
    cast(target_id as {{ dbt_utils.type_bigint() }}) as target_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(created_by as {{ dbt_utils.type_bigint() }}) as created_by,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(interact_id as {{ dbt_utils.type_string() }}) as interact_id,
    cast(target_type as {{ dbt_utils.type_string() }}) as target_type,
    cast(tag_category_id as {{ dbt_utils.type_bigint() }}) as tag_category_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tags_ab1') }}
-- tags
where 1 = 1
