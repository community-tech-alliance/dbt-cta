{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('knex_migrations_lock_ab1') }}
select
    cast(is_locked as {{ dbt_utils.type_bigint() }}) as is_locked,
    cast(index as {{ dbt_utils.type_bigint() }}) as index,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('knex_migrations_lock_ab1') }}
-- knex_migrations_lock
where 1 = 1
