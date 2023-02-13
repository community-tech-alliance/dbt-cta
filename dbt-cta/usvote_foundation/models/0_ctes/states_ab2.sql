{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_usvote_foundation",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('states_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(abbr as {{ dbt_utils.type_string() }}) as abbr,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(resource_uri as {{ dbt_utils.type_string() }}) as resource_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('states_ab1') }}
-- states
where 1 = 1

