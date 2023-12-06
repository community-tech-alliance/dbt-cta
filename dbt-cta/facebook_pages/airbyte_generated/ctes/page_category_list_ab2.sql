{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_category_list_ab1') }}
select
    _airbyte_page_hashid,
    cast(api_enum as {{ dbt_utils.type_string() }}) as api_enum,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_category_list_ab1') }}
-- category_list at page/category_list
where 1 = 1

