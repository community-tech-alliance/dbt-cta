{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('widgets_ab4') }}
select
    updated_at,
    name,
    created_at,
    id,
    number_of_measurables,
    column_span,
    block_id,
    widget_type,
    measurable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at,
    _airbyte_widgets_hashid
from {{ ref('widgets_ab4') }}
