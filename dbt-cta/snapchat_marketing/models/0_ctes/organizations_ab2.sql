{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organizations_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    roles,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(locality as {{ dbt_utils.type_string() }}) as locality,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(postal_code as {{ dbt_utils.type_string() }}) as postal_code,
    cast(contact_name as {{ dbt_utils.type_string() }}) as contact_name,
    cast(my_member_id as {{ dbt_utils.type_string() }}) as my_member_id,
    cast(contact_email as {{ dbt_utils.type_string() }}) as contact_email,
    cast(contact_phone as {{ dbt_utils.type_string() }}) as contact_phone,
    cast(address_line_1 as {{ dbt_utils.type_string() }}) as address_line_1,
    {{ cast_to_boolean('createdByCaller') }} as createdByCaller,
    cast(my_display_name as {{ dbt_utils.type_string() }}) as my_display_name,
    cast(my_invited_email as {{ dbt_utils.type_string() }}) as my_invited_email,
    {{ cast_to_boolean('contact_phone_optin') }} as contact_phone_optin,
    cast(accepted_term_version as {{ dbt_utils.type_string() }}) as accepted_term_version,
    cast(configuration_settings as {{ type_json() }}) as configuration_settings,
    cast(administrative_district_level_1 as {{ dbt_utils.type_string() }}) as administrative_district_level_1,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations_ab1') }}
-- organizations
where 1 = 1
