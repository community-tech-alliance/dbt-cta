{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tag_syndications_ab3') }}
select
    id,
    tag_id,
    group_id,
    tag_name,
    hierarchy,
    created_at,
    updated_at,
    source_group_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tag_syndications_hashid
from {{ ref('tag_syndications_ab3') }}
-- tag_syndications from {{ source('cta', '_airbyte_raw_tag_syndications') }}
where 1 = 1

