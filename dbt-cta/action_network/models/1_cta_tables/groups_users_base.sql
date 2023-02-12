{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('groups_users_ab3') }}
select
    id,
    hidden,
    user_id,
    approved,
    group_id,
    is_leader,
    created_at,
    updated_at,
    first_visit,
    join_message,
    user_permissions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_groups_users_hashid
from {{ ref('groups_users_ab3') }}
-- groups_users from {{ source('cta', '_airbyte_raw_groups_users') }}
where 1 = 1
