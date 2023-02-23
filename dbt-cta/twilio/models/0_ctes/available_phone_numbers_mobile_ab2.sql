{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('available_phone_numbers_mobile_ab1') }}
select
    {{ cast_to_boolean('beta') }} as beta,
    cast(lata as {{ dbt_utils.type_string() }}) as lata,
    cast(region as {{ dbt_utils.type_string() }}) as region,
    cast(latitude as {{ dbt_utils.type_string() }}) as latitude,
    cast(locality as {{ dbt_utils.type_string() }}) as locality,
    cast(longitude as {{ dbt_utils.type_string() }}) as longitude,
    cast(iso_country as {{ dbt_utils.type_string() }}) as iso_country,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    cast(rate_center as {{ dbt_utils.type_string() }}) as rate_center,
    cast(capabilities as {{ type_json() }}) as capabilities,
    {{ cast_to_boolean('capabilities_MMS') }} as capabilities_MMS,
    {{ cast_to_boolean('capabilities_SMS') }} as capabilities_SMS,
    {{ cast_to_boolean('capabilities_voice') }} as capabilities_voice,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(friendly_name as {{ dbt_utils.type_string() }}) as friendly_name,
    cast(address_requirements as {{ dbt_utils.type_string() }}) as address_requirements,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('available_phone_numbers_mobile_ab1') }}
-- available_phone_numbers_mobile
where 1 = 1

