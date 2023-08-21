{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('core_fields_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(street as {{ dbt_utils.type_string() }}) as street,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(language as {{ dbt_utils.type_string() }}) as language,
    cast(latitude as {{ dbt_utils.type_float() }}) as latitude,
    cast(owner_id as {{ dbt_utils.type_bigint() }}) as owner_id,
    cast(zip_code as {{ dbt_utils.type_string() }}) as zip_code,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(longitude as {{ dbt_utils.type_float() }}) as longitude,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(owner_type as {{ dbt_utils.type_string() }}) as owner_type,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('core_fields_ab1') }}
-- core_fields
where 1 = 1
