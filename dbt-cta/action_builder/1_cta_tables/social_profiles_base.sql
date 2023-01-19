{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('social_profiles_ab3') }}
select
    id,
    label,
    source,
    status,
    profile,
    entity_id,
    created_at,
    updated_at,
    created_by_id,
    updated_by_id,
    social_network_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_social_profiles_hashid
from {{ ref('social_profiles_ab3') }}
-- social_profiles from {{ source('cta', '_airbyte_raw_social_profiles') }}
where 1 = 1

