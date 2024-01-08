{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_schema_migrations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['version'], ['version']) }} as version,
    {{ json_extract_scalar('_airbyte_data', ['inserted_at'], ['inserted_at']) }} as inserted_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_schema_migrations') }}
-- schema_migrations
where 1 = 1
