{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('officials_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(fax as {{ dbt_utils.type_string() }}) as fax,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(office as {{ dbt_utils.type_string() }}) as office,
    cast(suffix as {{ dbt_utils.type_string() }}) as suffix,
    cast(initial as {{ dbt_utils.type_string() }}) as initial,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(office_name as {{ dbt_utils.type_string() }}) as office_name,
    cast(office_type as {{ dbt_utils.type_string() }}) as office_type,
    cast(resource_uri as {{ dbt_utils.type_string() }}) as resource_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('officials_ab1') }}
-- officials
where 1 = 1

