{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_usvote_foundation",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('offices_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(geoid as {{ dbt_utils.type_string() }}) as geoid,
    cast(hours as {{ dbt_utils.type_string() }}) as hours,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(region as {{ dbt_utils.type_string() }}) as region,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(updated as {{ dbt_utils.type_string() }}) as updated,
    addresses,
    officials,
    cast(resource_uri as {{ dbt_utils.type_string() }}) as resource_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('offices_ab1') }}
-- offices
where 1 = 1

