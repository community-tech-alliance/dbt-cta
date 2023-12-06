{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_cover_ab1') }}
select
    _airbyte_page_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(source as {{ dbt_utils.type_string() }}) as source,
    cast(cover_id as {{ dbt_utils.type_string() }}) as cover_id,
    cast(offset_x as {{ dbt_utils.type_float() }}) as offset_x,
    cast(offset_y as {{ dbt_utils.type_float() }}) as offset_y,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_cover_ab1') }}
-- cover at page/cover
where 1 = 1

