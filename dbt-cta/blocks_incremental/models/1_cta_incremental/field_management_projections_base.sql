{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('field_management_projections_ab3') }}
select
    end_date,
    turf_id,
    name,
    creator_id,
    id,
    total_collected,
    targets,
    start_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_field_management_projections_hashid
from {{ ref('field_management_projections_ab3') }}
-- field_management_projections from {{ source('cta', '_airbyte_raw_field_management_projections') }}
