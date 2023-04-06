{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tag_groups_ab3') }}
select
    id,
    name,
    target_id,
    created_at,
    created_by,
    updated_at,
    target_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tag_groups_hashid
from {{ ref('tag_groups_ab3') }}
-- tag_groups from {{ source('cta', '_airbyte_raw_tag_groups') }}
where 1 = 1

