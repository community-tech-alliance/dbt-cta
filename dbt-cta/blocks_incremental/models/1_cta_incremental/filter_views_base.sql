{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('filter_views_ab3') }}
select
    metadata,
    conjunction,
    updated_at,
    user_id,
    name,
    created_at,
    rules,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_filter_views_hashid
from {{ ref('filter_views_ab3') }}
-- filter_views from {{ source('cta', '_airbyte_raw_filter_views') }}

