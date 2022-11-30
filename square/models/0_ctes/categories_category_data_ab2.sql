{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('categories_category_data_ab1') }}
select
    _airbyte_categories_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('categories_category_data_ab1') }}
-- category_data at categories/category_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

