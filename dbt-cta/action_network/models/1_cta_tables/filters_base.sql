{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('filters_ab3') }}
select
    id,
    uuid,
    total,
    params,
    status,
    results,
    created_at,
    updated_at,
    backup_params,
    filterable_id,
    filterable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_filters_hashid
from {{ ref('filters_ab3') }}
-- filters from {{ source('cta', '_airbyte_raw_filters') }}
where 1 = 1

