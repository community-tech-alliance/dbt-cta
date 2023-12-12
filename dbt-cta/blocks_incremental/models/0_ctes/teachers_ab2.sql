{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('teachers_ab1') }}
select
    cast(congressional_district as {{ dbt_utils.type_string() }}) as congressional_district,
    cast(customer_address_id as {{ dbt_utils.type_bigint() }}) as customer_address_id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(latitude as {{ dbt_utils.type_float() }}) as latitude,
    cast(state_senate_district as {{ dbt_utils.type_string() }}) as state_senate_district,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(address_two as {{ dbt_utils.type_string() }}) as address_two,
    cast(county_name as {{ dbt_utils.type_string() }}) as county_name,
    cast(zipcode as {{ dbt_utils.type_string() }}) as zipcode,
    cast(county_fips as {{ dbt_utils.type_bigint() }}) as county_fips,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(state_house_district as {{ dbt_utils.type_string() }}) as state_house_district,
    cast(address_one as {{ dbt_utils.type_string() }}) as address_one,
    cast(census_block as {{ dbt_utils.type_string() }}) as census_block,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(longitude as {{ dbt_utils.type_float() }}) as longitude,
    cast(person_id as {{ dbt_utils.type_bigint() }}) as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teachers_ab1') }}
-- teachers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

