{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('discussion_forums_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'position',
        'forum_type',
        array_to_string('company_ids'),
        'description',
        'posts_count',
        'topics_count',
        'forum_visibility',
        'forum_category_id',
    ]) }} as _airbyte_discussion_forums_hashid,
    tmp.*
from {{ ref('discussion_forums_ab2') }} tmp
-- discussion_forums
where 1 = 1

