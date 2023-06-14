{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_knex_migrations_lock') }}
select
    {{ json_extract_scalar('_airbyte_data', ['is_locked'], ['is_locked']) }} as is_locked,
    {{ json_extract_scalar('_airbyte_data', ['index'], ['index']) }} as index,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_knex_migrations_lock') }} as table_alias
-- knex_migrations_lock
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

