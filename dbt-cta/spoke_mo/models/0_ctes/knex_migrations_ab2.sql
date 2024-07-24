{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('knex_migrations_ab1') }}
select
    cast({{ empty_string_to_null('migration_time') }} as {{ type_timestamp_with_timezone() }}) as migration_time,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(batch as {{ dbt_utils.type_bigint() }}) as batch,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('knex_migrations_ab1') }}
-- knex_migrations
where 1 = 1


