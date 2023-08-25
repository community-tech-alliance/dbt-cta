{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('offices_addresses_ab1') }}
select
    _airbyte_offices_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(zip as {{ dbt_utils.type_string() }}) as zip,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(zip4 as {{ dbt_utils.type_string() }}) as zip4,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(street1 as {{ dbt_utils.type_string() }}) as street1,
    cast(street2 as {{ dbt_utils.type_string() }}) as street2,
    cast(website as {{ dbt_utils.type_string() }}) as website,
    contacts,
    functions,
    cast(address_to as {{ dbt_utils.type_string() }}) as address_to,
    cast(main_email as {{ dbt_utils.type_string() }}) as main_email,
    cast(is_physical as {{ dbt_utils.type_string() }}) as is_physical,
    cast(resource_uri as {{ dbt_utils.type_string() }}) as resource_uri,
    cast(is_regular_mail as {{ dbt_utils.type_string() }}) as is_regular_mail,
    cast(main_fax_number as {{ dbt_utils.type_string() }}) as main_fax_number,
    cast(main_phone_number as {{ dbt_utils.type_string() }}) as main_phone_number,
    cast(primary_contact_uri as {{ dbt_utils.type_string() }}) as primary_contact_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('offices_addresses_ab1') }}
-- addresses at offices/addresses
where 1 = 1
