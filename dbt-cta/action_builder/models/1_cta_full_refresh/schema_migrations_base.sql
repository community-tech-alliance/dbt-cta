{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('schema_migrations_ab3') }}
select
    version,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_schema_migrations_hashid
from {{ ref('schema_migrations_ab3') }}
-- schema_migrations from {{ source('cta', '_airbyte_raw_schema_migrations') }}
where 1 = 1

