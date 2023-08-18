{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_knex_migrations_lock_hashid',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('knex_migrations_lock_ab3') }}
select
    is_locked,
    index,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_knex_migrations_lock_hashid
from {{ ref('knex_migrations_lock_ab3') }}
-- knex_migrations_lock from {{ source('cta', '_airbyte_raw_knex_migrations_lock') }}
where 1=1

