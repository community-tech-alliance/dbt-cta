{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('networks_users_ab3') }}
select
    id,
    user_id,
    created_at,
    network_id,
    updated_at,
    accepted_terms,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_networks_users_hashid
from {{ ref('networks_users_ab3') }}
-- networks_users from {{ source('cta', '_airbyte_raw_networks_users') }}
where 1 = 1

