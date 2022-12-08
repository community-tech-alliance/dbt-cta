{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cards,
    cast(address as {{ type_json() }}) as address,
    cast(version as {{ dbt_utils.type_bigint() }}) as version,
    cast(birthday as {{ dbt_utils.type_string() }}) as birthday,
    group_ids,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(given_name as {{ dbt_utils.type_string() }}) as given_name,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(family_name as {{ dbt_utils.type_string() }}) as family_name,
    cast(preferences as {{ type_json() }}) as preferences,
    segment_ids,
    cast(company_name as {{ dbt_utils.type_string() }}) as company_name,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(reference_id as {{ dbt_utils.type_string() }}) as reference_id,
    cast(email_address as {{ dbt_utils.type_string() }}) as email_address,
    cast(creation_source as {{ dbt_utils.type_string() }}) as creation_source,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_ab1') }}
-- customers
where 1 = 1

