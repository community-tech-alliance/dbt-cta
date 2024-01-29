{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('discussion_topic_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'hits',
        'title',
        boolean_to_string('locked'),
        boolean_to_string('sticky'),
        'message',
        'user_id',
        'forum_id',
        'created_at',
        'replied_by',
        'stamp_type',
        'updated_at',
        'user_votes',
        'posts_count',
        'merged_topic_id',
    ]) }} as _airbyte_discussion_topics_hashid,
    tmp.*
from {{ ref('discussion_topic_ab2') }} tmp
-- discussion_topics
where 1 = 1

