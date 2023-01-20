{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('knex_migrations_ab3') }}
select
    id,
    name,
    batch,
    migration_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_knex_migrations_hashid
from {{ ref('knex_migrations_ab3') }}
-- knex_migrations from {{ source('public', '_airbyte_raw_knex_migrations') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

