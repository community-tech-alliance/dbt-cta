{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('queries_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    {{ cast_to_boolean('public') }} as public,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    {{ cast_to_boolean('temporary') }} as temporary,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(query_type as {{ dbt_utils.type_bigint() }}) as query_type,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('queries_ab1') }}
-- queries
where 1 = 1
