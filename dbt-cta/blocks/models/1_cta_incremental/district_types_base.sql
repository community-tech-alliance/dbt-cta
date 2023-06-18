{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('district_types_ab3') }}
select
    updated_at,
    created_at,
    id,
    label,
    primary_key,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_district_types_hashid
from {{ ref('district_types_ab3') }}
-- district_types from {{ source('cta', '_airbyte_raw_district_types') }}

