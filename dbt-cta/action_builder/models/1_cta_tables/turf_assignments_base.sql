{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('turf_assignments_ab3') }}
select
    id,
    user_id,
    created_at,
    updated_at,
    campaign_id,
    restriction_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_turf_assignments_hashid
from {{ ref('turf_assignments_ab3') }}
-- turf_assignments from {{ source('cta', '_airbyte_raw_turf_assignments') }}
where 1 = 1

