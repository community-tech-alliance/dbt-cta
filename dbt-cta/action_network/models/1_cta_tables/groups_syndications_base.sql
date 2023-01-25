{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('groups_syndications_ab3') }}
select
    id,
    read,
    email_id,
    group_id,
    notified,
    action_id,
    created_at,
    updated_at,
    action_type,
    syndication_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_groups_syndications_hashid
from {{ ref('groups_syndications_ab3') }}
-- groups_syndications from {{ source('cta', '_airbyte_raw_groups_syndications') }}
where 1 = 1

