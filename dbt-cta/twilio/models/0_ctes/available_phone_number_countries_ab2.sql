{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('available_phone_number_countries_ab1') }}
select
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    {{ cast_to_boolean('beta') }} as beta,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(country_code as {{ dbt_utils.type_string() }}) as country_code,
    cast(subresource_uris as {{ type_json() }}) as subresource_uris,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('available_phone_number_countries_ab1') }}
-- available_phone_number_countries
where 1 = 1

