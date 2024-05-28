{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('comments_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_comments_hashid
from {{ ref('comments_ab4') }}