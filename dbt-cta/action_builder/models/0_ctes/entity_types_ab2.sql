{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('entity_types_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(icon as {{ dbt_utils.type_string() }}) as icon,
    cast(name_type as {{ dbt_utils.type_bigint() }}) as name_type,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(interact_id as {{ dbt_utils.type_string() }}) as interact_id,
    cast(name_plural as {{ dbt_utils.type_string() }}) as name_plural,
    {{ cast_to_boolean('email_enabled') }} as email_enabled,
    cast(name_singular as {{ dbt_utils.type_string() }}) as name_singular,
    {{ cast_to_boolean('social_enabled') }} as social_enabled,
    {{ cast_to_boolean('address_enabled') }} as address_enabled,
    {{ cast_to_boolean('language_enabled') }} as language_enabled,
    {{ cast_to_boolean('phone_number_enabled') }} as phone_number_enabled,
    {{ cast_to_boolean('date_of_birth_enabled') }} as date_of_birth_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('entity_types_ab1') }}
-- entity_types
where 1 = 1

