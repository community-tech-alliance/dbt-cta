{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('addresses_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(dw_id as {{ dbt_utils.type_string() }}) as dw_id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(source as {{ dbt_utils.type_string() }}) as source,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(accuracy as {{ dbt_utils.type_float() }}) as accuracy,
    cast(latitude as {{ dbt_utils.type_float() }}) as latitude,
    cast(owner_id as {{ dbt_utils.type_bigint() }}) as owner_id,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast(longitude as {{ dbt_utils.type_float() }}) as longitude,
    cast(complement as {{ dbt_utils.type_string() }}) as complement,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(owner_type as {{ dbt_utils.type_string() }}) as owner_type,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    {{ cast_to_boolean('geocode_bad') }} as geocode_bad,
    cast(interact_id as {{ dbt_utils.type_string() }}) as interact_id,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    cast(accuracy_type as {{ dbt_utils.type_string() }}) as accuracy_type,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast(updated_by_id as {{ dbt_utils.type_bigint() }}) as updated_by_id,
    cast(geocode_source as {{ dbt_utils.type_string() }}) as geocode_source,
    cast(street_address as {{ dbt_utils.type_string() }}) as street_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('addresses_ab1') }}
-- addresses
where 1 = 1
