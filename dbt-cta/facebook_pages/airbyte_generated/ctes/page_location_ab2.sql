{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_location_ab1') }}
select
    _airbyte_page_hashid,
    cast(zip as {{ dbt_utils.type_string() }}) as zip,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(latitude as {{ dbt_utils.type_float() }}) as latitude,
    cast(region_id as {{ dbt_utils.type_bigint() }}) as region_id,
    cast(country_code as {{ dbt_utils.type_string() }}) as country_code,
    cast(street as {{ dbt_utils.type_string() }}) as street,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(located_in as {{ dbt_utils.type_string() }}) as located_in,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(region as {{ dbt_utils.type_string() }}) as region,
    cast(city_id as {{ dbt_utils.type_bigint() }}) as city_id,
    cast(longitude as {{ dbt_utils.type_float() }}) as longitude,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_location_ab1') }}
-- location at page/location
where 1 = 1

