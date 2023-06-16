{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('dashboard_layouts_scd') }}
select
    _airbyte_unique_key,
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
from {{ ref('dashboard_layouts_scd') }}
-- dashboard_layouts from {{ source('sv_blocks', '_airbyte_raw_dashboard_layouts') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

