{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('discussion_comments_ab3') }}
select
    id,
    body,
    spam,
    trash,
    answer,
    user_id,
    forum_id,
    topic_id,
    published,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_discussion_comments_hashid
from {{ ref('discussion_comments_ab3') }}
-- discussion_comments from {{ source('freshdesk_partner_a', '_airbyte_raw_discussion_comments') }}
where 1 = 1

