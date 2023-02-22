{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('addresses_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(region as {{ dbt_utils.type_string() }}) as region,
    cast(street as {{ dbt_utils.type_string() }}) as street,
    {{ cast_to_boolean('verified') }} as verified,
    {{ cast_to_boolean('validated') }} as validated,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(iso_country as {{ dbt_utils.type_string() }}) as iso_country,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(customer_name as {{ dbt_utils.type_string() }}) as customer_name,
    cast(friendly_name as {{ dbt_utils.type_string() }}) as friendly_name,
    cast(street_secondary as {{ dbt_utils.type_string() }}) as street_secondary,
    {{ cast_to_boolean('emergency_enabled') }} as emergency_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('addresses_ab1') }}
-- addresses
where 1 = 1

