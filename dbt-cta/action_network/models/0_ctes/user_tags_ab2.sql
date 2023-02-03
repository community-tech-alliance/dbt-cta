{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_tags_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(tag_id as {{ dbt_utils.type_bigint() }}) as tag_id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_tags_ab1') }}
-- user_tags
where 1 = 1

