{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tag_syndications_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(tag_id as {{ dbt_utils.type_bigint() }}) as tag_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(tag_name as {{ dbt_utils.type_string() }}) as tag_name,
    cast(hierarchy as {{ dbt_utils.type_bigint() }}) as hierarchy,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(source_group_id as {{ dbt_utils.type_bigint() }}) as source_group_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tag_syndications_ab1') }}
-- tag_syndications
where 1 = 1

