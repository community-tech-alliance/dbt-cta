{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tags_ab3') }}
select
    id,
    name,
    text,
    status,
    tag_type,
    target_id,
    created_at,
    created_by,
    updated_at,
    interact_id,
    target_type,
    tag_category_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tags_hashid
from {{ ref('tags_ab3') }}
-- tags from {{ source('cta', '_airbyte_raw_tags') }}
where 1 = 1

