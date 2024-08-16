{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('solution_article_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(hits as {{ dbt_utils.type_bigint() }}) as hits,
    tags,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(agent_id as {{ dbt_utils.type_bigint() }}) as agent_id,
    cast(seo_data as {{ type_json() }}) as seo_data,
    cast(folder_id as {{ dbt_utils.type_bigint() }}) as folder_id,
    cast(thumbs_up as {{ dbt_utils.type_bigint() }}) as thumbs_up,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(category_id as {{ dbt_utils.type_bigint() }}) as category_id,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(thumbs_down as {{ dbt_utils.type_bigint() }}) as thumbs_down,
    cast(description_text as {{ dbt_utils.type_string() }}) as description_text,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('solution_article_ab1') }}
-- solution_articles
where 1 = 1

