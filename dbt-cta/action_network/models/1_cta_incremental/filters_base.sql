{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('filters_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_filters_hashid
from {{ ref('filters_ab4') }}