{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('comments_ab3') }}
select
    id,
    title,
    content,
    user_id,
    group_id,
    parent_id,
    created_at,
    updated_at,
    user_list_id,
    commentable_id,
    commentable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_comments_hashid
from {{ ref('comments_ab3') }}
-- comments from {{ source('cta', '_airbyte_raw_comments') }}
where 1 = 1

