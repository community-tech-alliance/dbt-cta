{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('dashboard_widgets_ab3') }}
select
    widget_id,
    updated_at,
    measurable_ids,
    created_at,
    id,
    position,
    title,
    measurable_type,
    dashboard_layout_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_dashboard_widgets_hashid
from {{ ref('dashboard_widgets_ab3') }}
-- dashboard_widgets from {{ source('sv_blocks', '_airbyte_raw_dashboard_widgets') }}

