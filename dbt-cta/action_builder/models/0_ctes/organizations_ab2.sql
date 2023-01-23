{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organizations_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(settings as {{ dbt_utils.type_string() }}) as settings,
    cast(subdomain as {{ dbt_utils.type_string() }}) as subdomain,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    {{ cast_to_boolean('api_enabled') }} as api_enabled,
    cast(country_code as {{ dbt_utils.type_string() }}) as country_code,
    cast(default_country as {{ dbt_utils.type_string() }}) as default_country,
    cast(administrator_user_id as {{ dbt_utils.type_bigint() }}) as administrator_user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations_ab1') }}
-- organizations
where 1 = 1

