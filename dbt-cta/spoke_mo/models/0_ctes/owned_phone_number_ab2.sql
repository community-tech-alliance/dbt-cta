{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('owned_phone_number_ab1') }}
select
    cast(service as {{ dbt_utils.type_string() }}) as service,
    cast(allocated_to_id as {{ dbt_utils.type_string() }}) as allocated_to_id,
    cast(area_code as {{ dbt_utils.type_string() }}) as area_code,
    cast(service_id as {{ dbt_utils.type_string() }}) as service_id,
    cast(allocated_to as {{ dbt_utils.type_string() }}) as allocated_to,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('allocated_at') }} as {{ type_timestamp_with_timezone() }}) as allocated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('owned_phone_number_ab1') }}
-- owned_phone_number
where 1 = 1


