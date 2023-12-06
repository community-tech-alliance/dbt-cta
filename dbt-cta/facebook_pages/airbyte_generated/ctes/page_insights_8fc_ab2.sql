{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_default",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_insights_8fc_ab1') }}
select
    cast(period as {{ dbt_utils.type_string() }}) as period,
    values,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_insights_8fc_ab1') }}
-- page_insights
where 1 = 1

