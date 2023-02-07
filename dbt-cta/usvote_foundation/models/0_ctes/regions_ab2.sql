{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_usvote_foundation",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('regions_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(county as {{ dbt_utils.type_string() }}) as county,
    cast(state_abbr as {{ dbt_utils.type_string() }}) as state_abbr,
    cast(state_name as {{ dbt_utils.type_string() }}) as state_name,
    cast(county_name as {{ dbt_utils.type_string() }}) as county_name,
    cast(region_name as {{ dbt_utils.type_string() }}) as region_name,
    cast(municipality as {{ dbt_utils.type_string() }}) as municipality,
    cast(resource_uri as {{ dbt_utils.type_string() }}) as resource_uri,
    cast(municipality_name as {{ dbt_utils.type_string() }}) as municipality_name,
    cast(municipality_type as {{ dbt_utils.type_string() }}) as municipality_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('regions_ab1') }}
-- regions
where 1 = 1

