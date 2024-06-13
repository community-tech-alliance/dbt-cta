{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ads_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(ad_squad_id as {{ dbt_utils.type_string() }}) as ad_squad_id,
    cast(creative_id as {{ dbt_utils.type_string() }}) as creative_id,
    cast(render_type as {{ dbt_utils.type_string() }}) as render_type,
    cast(review_status as {{ dbt_utils.type_string() }}) as review_status,
    delivery_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ads_ab1') }}
-- ads
where 1 = 1
