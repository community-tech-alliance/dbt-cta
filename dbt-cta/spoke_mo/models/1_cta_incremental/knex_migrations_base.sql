{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('knex_migrations_ab4') }}
select
    migration_time,
    name,
    batch,
    id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_knex_migrations_hashid
from {{ ref('knex_migrations_ab4') }}
where 1=1

