{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('dashboard_layouts_ab3') }}
select
    updated_at,
    name,
    created_at,
    id,
    created_by_user_id,
    content,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_dashboard_layouts_hashid
from {{ ref('dashboard_layouts_ab3') }}
-- dashboard_layouts from {{ source('cta', '_airbyte_raw_dashboard_layouts') }}
