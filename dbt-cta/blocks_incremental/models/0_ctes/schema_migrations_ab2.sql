{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('schema_migrations_ab1') }}
select
    cast(version as {{ dbt_utils.type_bigint() }}) as version,
    cast({{ empty_string_to_null('inserted_at') }} as {{ type_timestamp_without_timezone() }}) as inserted_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('schema_migrations_ab1') }}
-- schema_migrations
where 1 = 1
