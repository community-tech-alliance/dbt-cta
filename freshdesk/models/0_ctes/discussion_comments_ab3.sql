{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('discussion_comments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'body',
        boolean_to_string('spam'),
        boolean_to_string('trash'),
        boolean_to_string('answer'),
        'user_id',
        'forum_id',
        'topic_id',
        boolean_to_string('published'),
        'created_at',
        'updated_at',
    ]) }} as _airbyte_discussion_comments_hashid,
    tmp.*
from {{ ref('discussion_comments_ab2') }} tmp
-- discussion_comments
where 1 = 1

